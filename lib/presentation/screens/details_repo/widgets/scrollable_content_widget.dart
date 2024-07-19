import 'package:flutter/cupertino.dart';

class ScrollableContentWidget extends StatelessWidget {
  final Widget child;

  const ScrollableContentWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(child: child),
    );
  }
}