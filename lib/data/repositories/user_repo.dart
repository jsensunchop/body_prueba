import 'package:dio/dio.dart';
import 'package:prueba_tecnica/data/services/rest_client.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';

class UserRepo {

  //API LIST QUERY REPO

  static final UserRepo _userRepo = UserRepo._internal();

  factory UserRepo(){
    return _userRepo;
  }
  UserRepo._internal();

  static final dio = Dio(BaseOptions(
    contentType: "application/json",
  ));

  RestClient _client = RestClient(dio);


  //Get all posts from API
  Future<List<PostResponse>> fetchPosts() async{
    return await _client.getAllPosts();
  }

}