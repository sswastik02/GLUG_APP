import 'package:glug_app/models/devto_model.dart';

class DevToResponse {
  final List<DevTo> articles;
  final String error;

  DevToResponse.fromJSON(List<dynamic> json)
      : articles = json.map((data) => DevTo.fromJson(data)).toList(),
        error = "";

  DevToResponse.withError(String errorVal)
      : articles = List(),
        error = errorVal;
}
