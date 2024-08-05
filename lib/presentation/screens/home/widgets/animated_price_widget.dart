import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/styles/colors.dart';

class AnimatedPriceWidget extends StatefulWidget {
  final bool isPanelOpen;

  AnimatedPriceWidget(this.isPanelOpen);

  @override
  _AnimatedPriceWidgetState createState() => _AnimatedPriceWidgetState();
}

class _AnimatedPriceWidgetState extends State<AnimatedPriceWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = IntTween(begin: 0, end: 987).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedPriceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPanelOpen && !oldWidget.isPanelOpen) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 8.h,
          width: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: defaultLightBlack,
          ),
          child: Center(
            child: Text('\$${_animation.value}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white)),
          ),
        );
      },
    );
  }
}
