import 'package:glug_app/models/linit_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class LinitMagazinesBloc {
  final _repository = Repository();
  final _linitMagazinesFetcher = BehaviorSubject<LinitResponse>();

  Stream<LinitResponse> get allLinitMagazines => _linitMagazinesFetcher.stream;

  fetchAllLinitMagazines() async {
    LinitResponse linit = await _repository.fetchAllLinitMagazines();
    if (!_linitMagazinesFetcher.isClosed)
      _linitMagazinesFetcher.sink.add(linit);
  }

  dispose() {
    _linitMagazinesFetcher.close();
  }
}

final linitMagazinesBloc = LinitMagazinesBloc();
