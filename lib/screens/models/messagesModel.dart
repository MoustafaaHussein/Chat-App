import 'package:chatapp/helper/constants.dart';

class Messagesmodel {
  final String message;
  final String id;

  Messagesmodel(this.message, this.id);

  factory Messagesmodel.fromjson(jsonData) {
    return Messagesmodel(jsonData[kMessage], jsonData['id']);
  }
}
