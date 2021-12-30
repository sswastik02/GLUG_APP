import 'package:glug_app/models/profile_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfilesBloc {
  final _repository = Repository();
  final _profilesFetcher = BehaviorSubject<ProfileResponse>();

  Stream<ProfileResponse> get allProfiles => _profilesFetcher.stream;

  fetchAllProfiles() async {
    ProfileResponse profile = await _repository.fetchAllProfiles();
    if (!_profilesFetcher.isClosed) _profilesFetcher.sink.add(profile);
  }

  dispose() {
    _profilesFetcher.close();
  }
}

final profilesBloc = ProfilesBloc();
