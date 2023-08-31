import 'package:flutter/material.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({
    super.key,
    required this.onNewMessage,
    required this.child,
  });

  final ValueSetter<String> onNewMessage;
  final Widget child;

  @override
  State<ChatInputWidget> createState() => _State();
}

class _State extends State<ChatInputWidget> {
  final _controller = TextEditingController();

  void _onSubmit() {
    final text = _controller.text;
    if (text.isEmpty) return;
    widget.onNewMessage(text);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            widget.child,
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: _onSubmit,
                  icon: const Icon(Icons.send),
                ),
              ),
              onSubmitted: (_) => _onSubmit(),
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      );
}
