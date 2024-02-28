import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:dreamy_walls/domain/apiExtension.dart';
import '../../const/string.dart';
import 'failures.dart';

class ApiCaller {
  final Dio _dio = Dio();

  String baseUrl = unsplashDomain;

  Future<Either<Failure, Response>> homeApi(Map<String, dynamic> queryParameters) async {
    try {
      final response = await _dio.get(unsplashDomain.concat(homeEndPoint), queryParameters: queryParameters);
      return right(response);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
