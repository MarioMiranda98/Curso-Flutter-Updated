enum FromWho {
  me,
  her,
}

class MessageEntity {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  MessageEntity({
    this.imageUrl,
    required this.text,
    required this.fromWho,
  });
}
