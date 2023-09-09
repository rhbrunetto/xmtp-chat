import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    this.message,
    required this.onRetry,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = this.message;

    return Center(
      child: Column(
        children: [
          if (message != null)
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
