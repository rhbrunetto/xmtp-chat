import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

typedef ChatBuilder = Widget Function(BuildContext, ScrollController);

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({
    super.key,
    required this.onNewMessage,
    required this.builder,
  });

  final ValueSetter<String> onNewMessage;
  final ChatBuilder builder;

  @override
  State<ChatInputWidget> createState() => _State();
}

class _State extends State<ChatInputWidget> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

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
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: widget.builder(context, _scrollController),
                ),
              ),
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: _onSubmit,
                    icon: const Icon(Icons.send),
                  ),
                ),
                onSubmitted: (_) => _onSubmit(),
                onEditingComplete: ignore,
                textInputAction: TextInputAction.send,
              ),
            ],
          ),
        ),
      );
}
