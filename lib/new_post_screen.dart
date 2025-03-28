import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_sharing/home_screen.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedMedia = [];
  final Map<File, double> _filterStrength = {};
  final Map<File, String> _selectedFilters = {};

  final Map<String, Color> filterColors = {
    'none': Colors.transparent,
    'purple': Colors.purple.withOpacity(0.5),
    'blue': Colors.blue.withOpacity(0.5),
    'green': Colors.green.withOpacity(0.5),
  };

  Future<void> _pickMedia() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedMedia = pickedFiles.map((file) => File(file.path)).toList();
        for (var file in _selectedMedia) {
          _selectedFilters[file] = 'none';
          _filterStrength[file] = 0.5;
        }
      });
    }
  }

  void _openFilterDialog(File image) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apply Filter",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Image.file(image, width: 200, height: 200, fit: BoxFit.cover),
                  Container(
                    width: 200,
                    height: 200,
                    color: filterColors[_selectedFilters[image]],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    filterColors.keys.map((filterName) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilters[image] = filterName;
                            });
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: filterColors[filterName]!,
                            child:
                                filterName == 'none'
                                    ? Icon(Icons.cancel, color: Colors.black)
                                    : null,
                          ),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 10),
              Text("Adjust Strength"),
              Slider(
                value: _filterStrength[image]!,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _filterStrength[image] = value;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("New Post"),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => HomeScreen(
                        selectedImages:
                            _selectedMedia.map((file) => file.path).toList(),
                      ),
                ),
              );
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _pickMedia,
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text("Browse Images/Videos")),
            ),
          ),
          _selectedMedia.isNotEmpty
              ? Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      _selectedMedia.map((image) {
                        return GestureDetector(
                          onTap: () => _openFilterDialog(image),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Stack(
                              children: [
                                Image.file(
                                  image,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: 150,
                                  height: 150,
                                  color: filterColors[_selectedFilters[image]]
                                      ?.withOpacity(_filterStrength[image]!),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              )
              : Container(),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print("Post Clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: Text("Post"),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Reel Clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                  ),
                  child: Text("Reel", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
