import 'package:dekhlo/services/rest_client.dart';
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);

final restClient = RestClient(dio);
