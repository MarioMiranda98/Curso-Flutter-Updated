import 'package:flutter/material.dart';
import 'package:yes_no_maybe_app/domain/entities/message_entity.dart';

class HerMessageBubble extends StatelessWidget {
  final MessageEntity messageEntity;

  const HerMessageBubble({
    super.key,
    required this.messageEntity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              messageEntity.text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        _ImageBubble(imageUrl: messageEntity.imageUrl ?? ''),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        imageUrl,
        width: mq.size.width * 0.7,
        height: 150.0,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: mq.size.width * 0.7,
            height: 150.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: const Text('Mi amor está enviando una imagen.'),
          );
        },
      ),
    );
  }
}
