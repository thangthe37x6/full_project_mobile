import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'notifi.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3000/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("/data")
  Future<HttpResponse> getData();

  @POST("/register")
  Future<HttpResponse> register(@Body() User user);

  @POST("/login")
  Future<HttpResponse> login(@Body() User user);

  @POST("/notifi")
  Future<HttpResponse> placeOrder(@Body() Notifi notifi);
}
