// import 'package:retrofit_generator/retrofit_generator.dart'; // Solo quitar para correr build runner
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;


part 'rest_client.g.dart';

//Retrofit client for API requests

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("posts")
  Future<List<PostResponse>> getAllPosts();


}