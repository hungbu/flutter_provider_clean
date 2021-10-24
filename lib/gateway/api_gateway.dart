import 'package:dio/dio.dart';

const int CONNECTION_TIMEOUT = 30 * 1000; // 30s

class APIGateway {
  Dio _httpClient = Dio(BaseOptions(connectTimeout: CONNECTION_TIMEOUT, receiveTimeout: CONNECTION_TIMEOUT));

  Dio get httpClient {

      // set base url
      //_httpClient.options.baseUrl = "https://$domain/";

      // add onRequest interceptors
      // _httpClient.interceptors.add(
      //     InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      //
      //       options.headers.putIfAbsent(Headers.contentTypeHeader, () => ContentType.json.toString());
      //
      //       return handler.next(options);
      //     }, onError: (DioError dioError, ErrorInterceptorHandler handler) {
      //       return handler.next(dioError);
      //     }, onResponse: (response, handler) {
      //       return handler.next(response);
      //     }));

    return _httpClient;
  }

}