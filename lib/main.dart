import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_sharing/bloc/image_post_bloc.dart';

import 'package:photo_sharing/start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePostBloc(),
      child: MaterialApp(
        title: 'Photo Sharing App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: StartScreen(),
      ),
    );
  }
}
