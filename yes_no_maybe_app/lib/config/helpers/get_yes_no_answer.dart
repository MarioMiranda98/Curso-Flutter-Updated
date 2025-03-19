import 'package:dio/dio.dart';
import 'package:yes_no_maybe_app/domain/entities/message_entity.dart';
import 'package:yes_no_maybe_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<MessageEntity> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final YesNoModel yesNoModel = YesNoModel.fromJson(response.data);

    return yesNoModel.toMessageEntity();
  }
}
