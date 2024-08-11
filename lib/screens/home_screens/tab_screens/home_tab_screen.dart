import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hack_24/screens/utils/color.dart';

import '../../../constants/disease_identification.dart';
import '../../../main.dart';
import '../../utils/widgets/dcard.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  List<DImage> dls = Dintification.diseaseImages;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        print("path: ${image.path}   Mime type: ${image.mimeType}");

        setState(() {
          _image = File(image.path); // Convert the path to File
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.photo, color: Colors.white),
        onPressed: _pickImage,
        backgroundColor: AppColors.theme['primaryColor'],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: mq.width * 1,
              decoration: BoxDecoration(
                color: AppColors.theme['primaryColor']!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.search,
                      color: AppColors.theme['fontColor']!.withOpacity(0.6),
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Search Here",
                      style: TextStyle(
                        color: AppColors.theme['fontColor']!.withOpacity(0.6),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: dls.length,
                itemBuilder: (context, index) {
                  DImage dImage = dls[index];
                  return Dcard(di: dImage,) ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
