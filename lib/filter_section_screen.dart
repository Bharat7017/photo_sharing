import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:photo_sharing/bloc/image_post_bloc.dart';
import 'package:photo_sharing/bloc/image_post_event.dart';

class FilterSelectionScreen extends StatefulWidget {
  final String imagePath;
  const FilterSelectionScreen({super.key, required this.imagePath});

  @override
  _FilterSelectionScreenState createState() => _FilterSelectionScreenState();
}

class _FilterSelectionScreenState extends State<FilterSelectionScreen> {
  double _filterStrength = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Filters"),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<ImagePostBloc>(context).add(PostCreatedEvent());
              Navigator.pop(context);
            },
            child: Text("Done", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Image Preview:"),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(1 - _filterStrength),
              BlendMode.darken,
            ),
            child: Image.file(
              File(widget.imagePath),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          Slider(
            value: _filterStrength,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _filterStrength = value;
              });

              BlocProvider.of<ImagePostBloc>(
                context,
              ).add(FilterChangedEvent(_filterStrength));
            },
          ),
          Text("Filter Strength: ${_filterStrength.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
