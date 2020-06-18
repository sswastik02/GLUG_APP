import 'package:glug_app/models/linit_model.dart';

class LinitResponse {
  final List<Linit> linitMagazines;
  final String error;

  LinitResponse.fromJSON(List<dynamic> json)
      : linitMagazines = json.map((data) => Linit.fromJSON(data)).toList(),
        error = "";

  LinitResponse.withError(String errorVal)
      : linitMagazines = List(),
        error = errorVal;
}
