import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static String apiUrl = dotenv.env['API_URL'] ?? '';
}
