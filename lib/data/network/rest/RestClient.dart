import 'dart:convert';

import 'package:appentus_assignment/data/network/api/ApiEnum.dart';
import 'package:appentus_assignment/mapper/IMapper.dart';
import 'package:appentus_assignment/model/ApiError.dart';
import 'package:appentus_assignment/model/view/IViewModel.dart';
import 'package:dio/dio.dart';


abstract class ApiService {
  Dio _dio;
  String _baseUrl;
  bool isDebug = false;

  void reportError(ApiError dioError) {}

  ApiService(this._baseUrl, this.isDebug) {
    BaseOptions options = new BaseOptions(
      baseUrl: this._baseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );
    _dio = addInterceptors(Dio(options));
  }

  Dio addInterceptors(Dio dio) {
    dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => requestInterceptor(options),
          onResponse: (Response response) => responseInterceptor(response),
          onError: (DioError dioError) => errorInterceptor(dioError)));
    if (isDebug) {
      // Add this interceptor always in the end because each request has sequential calling of interceptors
      dio
        ..interceptors.add(LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true));
    }
    return dio;
  }

  dynamic requestInterceptor(RequestOptions options) async {
    return options;
  }

  dynamic responseInterceptor(Response options) async {
    return options;
  }

  dynamic errorInterceptor(DioError dioError) {
    ApiError error = ApiError();
    error.url = dioError.request.baseUrl + dioError.request.path;
    error.error = dioError.message;
    reportError(error);
    return dioError;
  }

  Stream<T> get<T extends IViewModel>({
    String endPoint,
    String query,
    IMapper mapper,
  }) async* {
    Uri uri = new Uri.https(_baseUrl, endPoint);
    if (query != null && query.isNotEmpty) {
      uri = uri.replace(query: query);
    }
    Response response = await _dio.get(
      uri.toString(),
    );
    T data = mapper.toViewModel(jsonEncode(response.data), response.statusCode);
    yield data;
  }

  Stream<T> apiRequest<T extends IViewModel>(
      {ApiType apiType, String endPoint, String queryParams, IMapper mapper}) {
    Stream<T> data;
    switch (apiType) {
      case ApiType.GET:
        data = get<T>(
          endPoint: endPoint,
          mapper: mapper,
          query: queryParams,
        );

        break;
    }
    return data;
  }
}
