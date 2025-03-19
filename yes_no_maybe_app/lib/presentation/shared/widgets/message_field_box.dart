import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onSendMessage;

  const MessageFieldBox({
    super.key,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40.0),
    );

    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      decoration: InputDecoration(
        hintText: 'End your message with ?',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            onSendMessage(textValue);
          },
        ),
      ),
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onSendMessage(value);
      },
    );
  }
}
