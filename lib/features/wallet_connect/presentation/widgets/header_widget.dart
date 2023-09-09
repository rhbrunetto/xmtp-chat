import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/fade_in_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInWidget(
            child: Text(
              context.l10n.loginTitle1,
              style: const TextStyle(fontSize: 36),
            ),
          ),
          FadeInWidget(
            index: 1,
            duration: const Duration(milliseconds: 600),
            child: Text(
              context.l10n.ethChat,
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          FadeInWidget(
            index: 2,
            duration: const Duration(milliseconds: 600),
            child: Text(context.l10n.loginSubtitle),
          ),
        ],
      );
}
