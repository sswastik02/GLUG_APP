import 'package:glug_app/models/blog_response.dart';
import 'package:glug_app/models/carousel_response.dart';
import 'package:glug_app/models/event_response.dart';
import 'package:glug_app/models/linit_response.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/models/profile_response.dart';
import 'package:glug_app/resources/api_provider.dart';

class Repository {
  final _apiProvider = ApiProvider();

  Future<EventResponse> fetchAllEvents() async => _apiProvider.fetchEventData();

  Future<BlogResponse> fetchAllBlogPosts() async =>
      _apiProvider.fetchBlogData();

  Future<LinitResponse> fetchAllLinitMagazines() async =>
      _apiProvider.fetchLinitData();

  Future<CarouselResponse> fetchAllCarouselData() async =>
      _apiProvider.fetchCarouselData();

  Future<ProfileResponse> fetchAllProfiles() async =>
      _apiProvider.fetchProfileData();

  Future<Notice> fetchAllNotices() async => _apiProvider.fetchNoticeData();
}
