import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'animated_price_widget.dart';


class BuildTestWidget extends StatefulWidget {
  final ThemeData theme;
  final bool isPanelOpen;
  final int index;

  const BuildTestWidget(this.theme, this.isPanelOpen, this.index, {super.key});

  @override
  State<BuildTestWidget>  createState() => _BuildTestWidgetState();
}

class _BuildTestWidgetState extends State<BuildTestWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300 * (widget.index + 1)),
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.index % 2 == 0 ? Offset(1.0, 0.0) : Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant BuildTestWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPanelOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: EdgeInsets.only(right: 2.h),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 10.h,
                  width: 35.h,
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('JKF - LAX', style: widget.theme.textTheme.titleSmall),
                            SizedBox(height: 2.h),
                            Text('10:25 - 12:50', style: widget.theme.textTheme.bodySmall),
                          ],
                        ),
                        SizedBox(width: 2.h),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Icon(Icons.swap_horizontal_circle_rounded, color: Colors.white),
                        ),
                        SizedBox(width: 2.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('LAX - JFK', style: widget.theme.textTheme.titleSmall),
                            SizedBox(height: 2.h),
                            Text('13:35 - 16:00', style: widget.theme.textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1.h,
                child: Container(
                  height: 8.h,
                  width: 8.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.theme.primaryColor,
                  ),
                  child: Icon(size: 4.h, Icons.calendar_month, color: Colors.white),
                ),
              ),
              Positioned(
                top: 1.h,
                right: 0.h,
                child: AnimatedPriceWidget(widget.isPanelOpen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
