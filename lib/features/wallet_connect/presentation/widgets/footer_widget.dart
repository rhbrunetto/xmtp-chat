import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/colors.dart';
import '../../../../utils/extensions.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextButton.icon(
            onPressed: () => context.openLink('https://xmtp.org'),
            style: _style,
            label: Text(context.l10n.xmtpFooter),
            icon: Assets.icons.xmtpIcon.svg(color: EthColors.violetBlue),
          ),
          TextButton.icon(
            onPressed: () =>
                context.openLink('https://github.com/rhbrunetto/xmtp-chat'),
            style: _style,
            label: Text(context.l10n.githubFooter),
            icon: Assets.icons.githubIcon.svg(color: EthColors.violetBlue),
          ),
        ],
      );
}

final _style = TextButton.styleFrom(
  foregroundColor: EthColors.violetBlue,
  backgroundColor: Colors.transparent,
  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
);
