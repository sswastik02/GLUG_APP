import 'package:glug_app/models/techbytes_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TechbytesBloc {
  final _repository = Repository();
  final _techbytesfetcher = BehaviorSubject<TechbytesResponse>();

  Stream<TechbytesResponse> get allTechBytes => _techbytesfetcher.stream;

  fetchTechbytes() async {
    TechbytesResponse techbyte = await _repository.fetchAllTechbytes();
    if (!_techbytesfetcher.isClosed) _techbytesfetcher.sink.add(techbyte);
  }

  dispose() {
    _techbytesfetcher.close();
  }
}

final techbytesBloc = TechbytesBloc();
