import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';
import 'package:github_search_app/presentation/screens/home/widgets/bar_chart.dart';

import 'package:sizer/sizer.dart';
import '../../../bloc/home_repo/home_repo_bloc.dart';
import '../../../bloc/home_repo/home_repo_event.dart';
import '../../../bloc/search_repo/search_repo_bloc.dart';
import '../../search_repo/search_screen.dart';
import 'build_widget_test.dart';

class PanelContent extends StatefulWidget {
  final ScrollController scrollController;
  final bool isPanelOpen;

  const PanelContent(this.scrollController, this.isPanelOpen, {super.key});

  @override
  State<PanelContent> createState() => _PanelContentState();
}

class _PanelContentState extends State<PanelContent> with TickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _rotationAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.linear,
    ));

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant PanelContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPanelOpen) {
      _iconController.animateTo(0.0, duration: const Duration(seconds: 1), curve: Curves.linear);
      _fadeController.forward();
    } else {
      _iconController.repeat();
      _fadeController.reverse();
    }
  }

  @override
  void dispose() {
    _iconController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: widget.scrollController,
        children: <Widget>[
          SizedBox(height: 12.0),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ),
          SizedBox(height: 18.0),
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
          SizedBox(height: 5.h),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(size: 4.h, Icons.calendar_month, color: Colors.white),
                  ),
                  Column(
                    children: [
                      Text('Price', style: theme.textTheme.titleSmall),
                      SizedBox(height: 1.h),
                      Text('Jan, 2020', style: theme.textTheme.bodySmall),
                    ],
                  ),
                  Container(
                    height: 7.h,
                    width: 7.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black),
                    child: RotationTransition(
                      turns: _rotationAnimation,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.h),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: 10.h,
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
              ),
              child: BarChartSample3(),
            ),
          ),
          SizedBox(height: 5.h),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 4.w),
                  child: BuildTestWidget(theme, widget.isPanelOpen, index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
