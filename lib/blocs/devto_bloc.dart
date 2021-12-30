import 'package:glug_app/models/devto_model.dart';
import 'package:glug_app/models/devto_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DevToBloc {
  final _repository = Repository();
  final _devToFetcher = BehaviorSubject<DevToResponse>();

  Stream<DevToResponse> get alldevArticles => _devToFetcher.stream;

  fetchDevArticles() async {
    DevToResponse devArticle = await _repository.fetchAllDevTo();
    if (!_devToFetcher.isClosed) _devToFetcher.sink.add(devArticle);
  }

  dispose() {
    _devToFetcher.close();
  }
}

final devToBloc = DevToBloc();
