import 'package:flutter/material.dart';

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
        title: const Text('Recipient address'),
        contentPadding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _recipientController,
          ),
          TextButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
        ],
      );
}
