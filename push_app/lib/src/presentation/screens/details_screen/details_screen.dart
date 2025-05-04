import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/src/domain/entities/push_message_entity.dart';
import 'package:push_app/src/presentation/blocs/notifications_bloc/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.pushMessageId});

  final String pushMessageId;

  @override
  Widget build(BuildContext context) {
    final PushMessageEntity? message = context
        .read<NotificationsBloc>()
        .getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalles push')),
      body:
          message != null
              ? _DetailsView(message: message)
              : Center(
                child: Text('Notificación con id: $pushMessageId no existe'),
              ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({required this.message});

  final PushMessageEntity message;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          if (message.imageUrl != null) Image.network(message.imageUrl!),

          const SizedBox(height: 30.0),

          Text(message.title, style: textStyles.titleMedium),
          Text(message.body),

          const Divider(),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
