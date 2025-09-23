import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pts_kasiraj/home.dart';
import 'package:pts_kasiraj/regist.dart';
import 'package:pts_kasiraj/cart.dart';
import 'package:pts_kasiraj/product.dart';
import 'package:pts_kasiraj/histo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart';

class Utama extends StatefulWidget {
  const Utama({super.key});

  @override
  State<Utama> createState() => _UtamaState();
}

class _UtamaState extends State<Utama> {
   final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _subtitle = TextEditingController();
  String result = "";
  // add a text field for title and subtitle and a button to save the note
  Future<void> addNote() async {
    final response = await post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: {
        'title': _title.text,
        'body': _subtitle.text,
      },
    );
    if (response.statusCode == 201) {
      setState(() {
        result = response.body;
      });
    } else {
      setState(() {
        result = 'Failed to add note';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter'),
        ),
        body: Column(
          children: [
            SnackBar(content:  Text("result: $result")),
            
            ElevatedButton(
              onPressed: () async {
                await showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40,
                                top: -40,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: _title,
                                        decoration: const InputDecoration(
                                          hintText: 'Title',)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: _subtitle,
                                        decoration: const InputDecoration(
                                          hintText: 'Subtitle',)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ElevatedButton(
                                        child: const Text('Submit'),
                                        onPressed: () {
                                          addNote();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
              },
              child: Icon(Icons.add)
            ),
          ],
        ),
      );
}
