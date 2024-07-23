import 'package:dekhlo/services/rest_client.dart';
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);

final post = Dio(
  BaseOptions(
    headers: {'Content-Type': 'multipart/form-data'},
  ),
);
final restClient = RestClient(dio);
final postdio = RestClient(post);
