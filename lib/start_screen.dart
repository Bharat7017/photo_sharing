import 'package:flutter/material.dart';
import 'package:photo_sharing/new_post_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPostScreen()),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          child: Text('Start', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
