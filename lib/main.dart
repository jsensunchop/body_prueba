import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/domain/bloc/publications_bloc/publication_bloc.dart';
import 'package:prueba_tecnica/views/login_page.dart';
void main() {
  final userRepo = UserRepo();
  runApp(
      MultiBlocProvider(providers: [
        BlocProvider<PublicationBloc>(create: (context){
          return PublicationBloc(userRepo)..add(FetchPublication());
        }),

      ],
          child: MyApp())

  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: LoginPage(),
    );
  }
}