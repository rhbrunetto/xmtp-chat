import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

class NewChatDialog extends StatefulWidget {
  const NewChatDialog({super.key});

  @override
  State<NewChatDialog> createState() => _NewChatDialogState();
}

class _NewChatDialogState extends State<NewChatDialog> {
  final _recipientController = TextEditingController();

  void _submit() {
    final value = _recipientController.text;
    if (value.isEmpty) return;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: Text(context.l10n.newChatTitle),
        contentPadding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _recipientController,
            maxLines: 1,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            onFieldSubmitted: (_) => _submit(),
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: _submit,
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      );
}
