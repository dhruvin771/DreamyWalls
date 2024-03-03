import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dreamy_walls/extension/api_extension.dart';

import '../../const/string.dart';
import 'failures.dart';

class ApiCaller {
  final Dio _dio = Dio();

  String baseUrl = unsplashDomain;

  Future<Either<Failure, Response>> homeApi(
      Map<String, dynamic> queryParameters) async {
    try {
      final response = await _dio.get(unsplashDomain.concat(homeEndPoint),
          queryParameters: queryParameters);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Response>> categoriesApi(
      Map<String, dynamic> queryParameters, String title) async {
    try {
      final response = await _dio.get(
          '${unsplashDomain.concat(categoriesEndPoint)}$title/photos',
          queryParameters: queryParameters);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
