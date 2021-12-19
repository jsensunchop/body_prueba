import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prueba_tecnica/domain/bloc/publications_bloc/publication_bloc.dart';
import 'package:prueba_tecnica/utils/firebase_auth.dart';
import 'package:prueba_tecnica/views/details_page.dart';
import 'package:prueba_tecnica/views/login_page.dart';

class ProfilePage extends StatefulWidget {
  // Obtain a list of the available cameras on the device.

  final User user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  File? image;


  late User _currentUser;

  Future pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });

  }

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Camera',
              ),
              //child: Image.asset('images/android.png'),

              Tab(
                text: 'Publications',
              ),
              Tab(
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    OutlinedButton(
                      onPressed: (){
                          pickImage();
                      },
                      child: Text(
                          "Take a picture"
                      ),

                    ),

                    image != null?
                    Image.file(image!, width: 200, height: 400,) :Text("No picture taken")
                  ],
                )
            ),
            Column(
              children: [
                BlocBuilder<PublicationBloc, PublicationState>(
                    builder: (context, state) {
                  if (state is PublicationsFetched) {
                    return Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                      DetailsPage(
                                        userId: state.posts[index].userId,
                                        id: state.posts[index].id,
                                        title: state.posts[index].title,
                                        body: state.posts[index].body,
                                      )));
                                },
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ListTile(
                                      // leading: Text(
                                      //   state.posts[index].title,
                                      //   style: const TextStyle(
                                      //       fontSize: 14.0,
                                      //       color: Style.Colors.mainColor,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      title: Text(
                                        state.posts[index].title.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle: Text(
                                      //   snapshot.data![index].body,
                                      //   style: const TextStyle(fontSize: 14.0),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                }),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NAME: ${_currentUser.displayName}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'EMAIL: ${_currentUser.email}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 16.0),
                  _currentUser.emailVerified
                      ? Text(
                          'Email verified',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.green),
                        )
                      : Text(
                          'Email not verified',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.red),
                        ),
                  SizedBox(height: 16.0),
                  _isSendingVerification
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isSendingVerification = true;
                                });
                                await _currentUser.sendEmailVerification();
                                setState(() {
                                  _isSendingVerification = false;
                                });
                              },
                              child: Text('Verify email'),
                            ),
                            SizedBox(width: 8.0),
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () async {
                                User? user =
                                    await FirebaseAuthenticator.refreshUser(
                                        _currentUser);

                                if (user != null) {
                                  setState(() {
                                    _currentUser = user;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                  SizedBox(height: 16.0),
                  _isSigningOut
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await FirebaseAuth.instance.signOut();
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text('Sign out'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
