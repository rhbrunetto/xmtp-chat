import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension BuildContextExt on BuildContext {
  Future<void> openLink(String link) =>
      tryEitherAsync((_) async => launchUrlString(link));
}
