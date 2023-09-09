import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RefreshableWidget extends StatelessWidget {
  const RefreshableWidget({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final AsyncCallback onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: child,
            ),
          ),
        ),
      );
}
