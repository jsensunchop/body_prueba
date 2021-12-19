import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
        required this.userId,
        required this.id,
        required this.title,
        required this.body})
      : super(key: key);

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Prueba de ingreso"),
          backgroundColor: Colors.cyan,
        ),
        body: Column(
                  children: [
                    Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                widget.title,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                widget.body,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                widget.id.toString(),
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            );
  }
}