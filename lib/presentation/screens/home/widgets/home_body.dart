import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:github_search_app/presentation/screens/home/widgets/carousel/carousel_widget.dart';
import 'package:github_search_app/presentation/screens/home/widgets/panel/panel_content.dart';
import '../../../bloc/home_repo/home_repo_bloc.dart';
import '../../../bloc/home_repo/home_repo_state.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final PanelController _panelController = PanelController();
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  bool _isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _panelHeightOpen = MediaQuery.of(context).size.height * .95;

    return Stack(
      children: [
        SlidingUpPanel(
          controller: _panelController,
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
          panelBuilder: (sc) => PanelContent(sc, _isPanelOpen, _panelController),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          onPanelSlide: (double pos) {
            setState(() {
              _isPanelOpen = pos >= 1.0;
            });
          },
        ),
      ],
    );
  }
}
