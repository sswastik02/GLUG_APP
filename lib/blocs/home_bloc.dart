import 'package:glug_app/models/carousel_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Repository();
  final _carouselFetcher = BehaviorSubject<CarouselResponse>();

  Stream<CarouselResponse> get allData => _carouselFetcher.stream;

  fetchAllData() async {
    CarouselResponse carousel = await _repository.fetchAllCarouselData();
    if (!_carouselFetcher.isClosed) _carouselFetcher.sink.add(carousel);
  }

  dispose() {
    _carouselFetcher.close();
  }
}

final homeBloc = HomeBloc();
