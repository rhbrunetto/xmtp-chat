import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/fade_in_widget.dart';
import '../../../session/data/session.dart';

// TODO(rhbrunetto): For some reason, wallet app might not be launched, so this screen is needed
class XmtpLoadingWidget extends StatelessWidget {
  const XmtpLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                FadeInWidget(
                  delay: _delay,
                  child: Text(
                    context.l10n.xmtpSignTitle,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInWidget(
                  index: 1,
                  delay: _delay,
                  child: Text(
                    context.l10n.xmtpSignSubtitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 100),
                FadeInWidget(
                  index: 2,
                  delay: _delay,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        context.l10n.xmtpInstructions1,
                        style: const TextStyle(fontSize: 18),
                        // textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.l10n.xmtpInstructions2,
                        style: const TextStyle(fontSize: 18),
                        // textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                TextButton.icon(
                  onPressed: () => context.read<Session>().openWallet(),
                  label: Text(context.l10n.openWallet),
                  icon: const Icon(Icons.open_in_new),
                ),
              ],
            ),
          ),
        ),
      );
}

const _delay = Duration(milliseconds: 600);
