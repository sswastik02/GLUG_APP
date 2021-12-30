import 'package:glug_app/models/techbytes_model.dart';

class TechbytesResponse {
  final List<Techbytes> techbyte;
  final String error;

  TechbytesResponse.fromJSON(List<dynamic> json)
      : techbyte = json.map((data) => Techbytes.fromJson(data)).toList(),
        error = "";

  TechbytesResponse.withError(String errorVal)
      : techbyte = List(),
        error = errorVal;
}
