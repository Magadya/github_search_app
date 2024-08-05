import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';
import 'package:github_search_app/presentation/screens/home/widgets/carousel_widget.dart';
import 'package:github_search_app/presentation/screens/home/widgets/panel_content.dart';
import 'package:github_search_app/presentation/screens/home/widgets/settings_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/resources/strings/app_strings.dart';
import '../../bloc/home_repo/home_repo_bloc.dart';
import '../../bloc/home_repo/home_repo_event.dart';
import '../../bloc/home_repo/home_repo_state.dart';
import '../../bloc/search_repo/search_repo_bloc.dart';
import '../search_repo/search_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  bool _isPanelOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeRepoBloc>().add(HomeInitialRequested());
    });
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
            body: BlocBuilder<HomeRepoBloc, HomeRepoState>(
              builder: (context, state) {
                if (state is HomeRepoLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeRepoLoadedState) {
                  return CarouselWidget(list: state.repos);
                } else if (state is HomeRepoErrorState) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            panelBuilder: (sc) => PanelContent(sc, _isPanelOpen),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            onPanelSlide: (double pos) {
              setState(() {
                _isPanelOpen = pos >= 1.0;
              });
            },
          ),
        ],
      ),
    );
  }
}


