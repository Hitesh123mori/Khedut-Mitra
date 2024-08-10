import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hack_24/screens/utils/color.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  File? _image; // Variable to hold the selected image
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // You can handle the image further here (e.g., upload it to a server)
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.photo, color: Colors.white),
          onPressed: _pickImage, // Call _pickImage method on press
          backgroundColor: AppColors.theme['primaryColor'],
        ),
        body: Center(
          child: _image == null
              ? Text('No image selected.')
              : Image.file(_image!), // Display the selected image
        ),
      ),
    );
  }
}
