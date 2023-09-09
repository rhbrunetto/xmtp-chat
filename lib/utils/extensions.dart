import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../l10n/l10n.dart';

extension BuildContextExt on BuildContext {
  Future<void> openLink(String link) =>
      tryEitherAsync((_) async => launchUrlString(link));

  String elapsedTimeFormatted(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    return switch (difference) {
      Duration(inDays: final d) when d > 0 => l10n.durationInDays(d),
      Duration(inHours: final h) when h > 0 => l10n.durationInHours(h),
      Duration(inMinutes: final m) when m > 0 => l10n.durationInMinutes(m),
      Duration(inSeconds: final s) => l10n.durationInSeconds(s),
    };
  }
}
