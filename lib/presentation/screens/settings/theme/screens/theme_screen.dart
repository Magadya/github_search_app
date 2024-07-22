import 'package:flutter/material.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';

import '../../../../../core/resources/styles/colors.dart';
import '../../../../../data/di/di.dart';
import '../../../../cubit/global/global_cubit.dart';




class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

const _animationDuration = Duration(milliseconds: 700);
const _animationCurve = Curves.fastOutSlowIn;
const double _circleRadius = 120;
const double _chainInitialHeight = 80;
const double _chainThickness = 2;
const double _chainHandleRadius = 16;
const _chainHandleHoldDuration = Duration(seconds: 0);
const _chainHandleReleaseDuration = Duration(seconds: 1);
const _chainHandleAnimationCurve = Curves.elasticOut;

class _ThemeScreenState extends State<ThemeScreen> {
  double chainHeight = _chainInitialHeight;
  bool isHoldingHandle = false;
  final GlobalCubit globalCubit = sl<GlobalCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: context.pop,
        ),
        title: const Text('Theme Screen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: _animationDuration,
            curve: _animationCurve,
            color: sl<GlobalCubit>().isLightTheme ? dayBGColor : nightBGColor,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  width: _circleRadius,
                  height: _circleRadius,
                  duration: _animationDuration,
                  curve: _animationCurve,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sl<GlobalCubit>().isLightTheme ? sunColor : moonColor,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-25, -25),
                  child: AnimatedContainer(
                    width: sl<GlobalCubit>().isLightTheme ? 0 : _circleRadius,
                    height: sl<GlobalCubit>().isLightTheme ? 0 : _circleRadius,
                    duration: _animationDuration,
                    curve: _animationCurve,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sl<GlobalCubit>().isLightTheme ? dayBGColor : nightBGColor,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight / 2 + (_circleRadius / 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: isHoldingHandle ? _chainHandleHoldDuration : _chainHandleReleaseDuration,
                        curve: _chainHandleAnimationCurve,
                        height: chainHeight,
                        child: VerticalDivider(
                          color: sl<GlobalCubit>().isLightTheme ? sunColor : moonColor,
                          thickness: _chainThickness,
                        ),
                      ),
                      GestureDetector(
                        onVerticalDragUpdate: (dragDetails) {
                          setState(() {
                            if (!isHoldingHandle) isHoldingHandle = true;
                            chainHeight += dragDetails.primaryDelta ?? 0;
                          });
                        },
                        onVerticalDragEnd: (_) => _updateAllStates(),
                        onVerticalDragCancel: () => _updateAllStates(),
                        child: Container(
                          width: _chainHandleRadius,
                          height: _chainHandleRadius,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sl<GlobalCubit>().isLightTheme ? sunColor : moonColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _updateAllStates() => setState(() {
    if (isHoldingHandle) isHoldingHandle = false;
    if (chainHeight > _chainInitialHeight * 1.5) sl<GlobalCubit>().setAppTheme();
    chainHeight = _chainInitialHeight;
  });
}


