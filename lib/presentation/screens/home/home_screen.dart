import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';
import 'package:github_search_app/presentation/screens/home/widgets/carousel_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/resources/strings/app_strings.dart';
import '../../../core/resources/styles/colors.dart';
import '../../bloc/home_repo/home_repo_bloc.dart';
import '../../bloc/home_repo/home_repo_event.dart';
import '../../bloc/home_repo/home_repo_state.dart';
import '../../bloc/search_repo/search_repo_bloc.dart';
import '../details_repo/details_repo_screen.dart';
import '../search_repo/search_screen.dart';
import '../search_repo/widgets/repo_item.dart';
import 'widgets/settings_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeRepoBloc>().add(HomeInitialRequested());
    });
    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _panelHeightOpen = MediaQuery.of(context).size.height * .95;
    return Scaffold(
      drawer: const SettingsWidget(),
      appBar: AppBar(
        title: const Text('GitHub Repo Search', style: TextStyle(color: Colors.black, fontSize: 14)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push(BlocProvider.value(
                value: BlocProvider.of<SearchRepoBloc>(context, listen: false),
                child: const SearchScreen(),
              ));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            color: theme.primaryColor,
            // body: BlocBuilder<HomeRepoBloc, HomeRepoState>(
            //   builder: (context, state) {
            //     if (state is HomeRepoLoadingState) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is HomeRepoLoadedState) {
            //       return CarouselWidget(list: state.repos);
            //     } else if (state is HomeRepoErrorState) {
            //       return Center(child: Text(state.message));
            //     }
            //     return const Center(child: Text(AppStrings.pullToRefresh));
            //   },
            // ),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
            }),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    final theme = Theme.of(context).textTheme;
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration:
                      BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    context.read<HomeRepoBloc>().add(HomeInitialRequested());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    context.push(BlocProvider.value(
                      value: BlocProvider.of<SearchRepoBloc>(context, listen: false),
                      child: const SearchScreen(),
                    ));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  child: Icon(
                    size: 4.h,
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Price', style: theme.titleSmall),
                      SizedBox(height: 1.h),
                      Text('Jan, 2020', style: theme.bodySmall),
                    ],
                  ),
                ),
                Container(
                  height: 7.h,
                  width: 7.h,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: defaultLightBlack),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Icon(
                    size: 4.h,
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 2.h,
                ),
                Stack(
                  children: [
                    Container(
                      height: 10.h,
                      width: 40.h,
                      color: Colors.white,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('JKF - LAX', style: theme.titleSmall),
                                SizedBox(height: 2.h),
                                Text('10:25 - 12:50', style: theme.bodySmall),
                              ],
                            ),
                            SizedBox(width: 2.h),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: defaultLightBlack,
                              ),
                              child: Icon(
                                Icons.swap_horizontal_circle_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 2.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('LAX - JFK', style: theme.titleSmall),
                                SizedBox(height: 2.h),
                                Text('13:35 - 16:00', style: theme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 1.h,
                      child: Container(
                        height: 8.h,
                        width: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: defaultLightBlack,
                        ),
                        child: Center(
                          child: Text('\$987', style: theme.titleSmall?.copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
