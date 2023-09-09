import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../ui/colors.dart';

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

  @override
  void initState() {
    super.initState();
  }

  void _onSubmit() {
    final text = _controller.text;
    if (text.isEmpty) return;
    widget.onNewMessage(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: widget.child,
            ),
          ),
          Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    onPressed: _onSubmit,
                    icon: const Icon(Icons.send),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: EthColors.cherryPink),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onSubmitted: (_) => _onSubmit(),
                onEditingComplete: ignore,
                textInputAction: TextInputAction.send,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      );
}
