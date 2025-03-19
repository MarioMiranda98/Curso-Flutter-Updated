import 'package:yes_no_maybe_app/domain/entities/message_entity.dart';

class YesNoModel {
  final String answer;
  final bool forced;
  final String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromJson(Map<String, dynamic> json) => YesNoModel(
        answer: json['answer'],
        forced: json['forced'],
        image: json['image'],
      );

  MessageEntity toMessageEntity() => MessageEntity(
        text: answer == 'yes' ? 'Si' : 'No',
        fromWho: FromWho.her,
        imageUrl: image,
      );
}
