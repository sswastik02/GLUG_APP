import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:glug_app/models/blog_response.dart';
import 'package:glug_app/models/carousel_response.dart';
import 'dart:async';
import 'package:glug_app/models/event_response.dart';
import 'package:glug_app/models/linit_response.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/models/profile_response.dart';

class ApiProvider {
  static final String baseURL = "https://api.nitdgplug.org";
  static final String eventsURL = "$baseURL/api/events/";
  static final String blogPostsURL = "$baseURL/blog/posts/";
  static final String profilesURL = "$baseURL/api/profiles/";
  static final String linitURL = "$baseURL/api/linit/";
  static final String carouselURL = "$baseURL/api/carousel/";
  static final String noticeURL =
      "https://admin.nitdgp.ac.in/academics/notices";

  final Dio _dio = new Dio();

  Future<EventResponse> fetchEventData() async {
    print("Entered");

    try {
      Response response = await _dio.get(eventsURL);
      print(response.data.toString());
      return EventResponse.fromJSON(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return EventResponse.withError("$error");
    }
  }

  Future<BlogResponse> fetchBlogData() async {
    print("Entered");

    try {
      Response response = await _dio.get(blogPostsURL);
      print(response.data.toString());
      return BlogResponse.fromJSON(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return BlogResponse.withError("$error");
    }
  }

  Future<LinitResponse> fetchLinitData() async {
    print("Entered");

    try {
      Response response = await _dio.get(linitURL);
      print(response.data.toString());
      return LinitResponse.fromJSON(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return LinitResponse.withError("$error");
    }
  }

  Future<CarouselResponse> fetchCarouselData() async {
    print("Entered");

    try {
      Response response = await _dio.get(carouselURL);
      print(response.data.toString());
      return CarouselResponse.fromJSON(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return CarouselResponse.withError("$error");
    }
  }

  Future<ProfileResponse> fetchProfileData() async {
    print("Entered");

    try {
      Response response = await _dio.get(profilesURL);
      print(response.data.toString());
      return ProfileResponse.fromJSON(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ProfileResponse.withError("$error");
    }
  }

  Future<Notice> fetchNoticeData() async {
    try {
      Response response = await _dio.get(noticeURL);
      print(response.data.toString());
      return Notice.fromJson(json.decode(response.data));
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return null;
    }
  }
}
