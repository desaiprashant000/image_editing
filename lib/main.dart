import 'package:flutter/material.dart';
import 'package:image_editing/image_editing.dart';
import 'package:image_editing/photo_Editing.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: image(),
    );
  }
}
