import 'package:glug_app/models/profile_model.dart';

class ProfileResponse {
  final List<Profile> profiles;
  final String error;

  ProfileResponse.fromJSON(List<dynamic> json)
      : profiles = json.map((data) => Profile.fromJson(data)).toList(),
        error = "";

  ProfileResponse.withError(String errorVal)
      : profiles = List(),
        error = errorVal;
}
