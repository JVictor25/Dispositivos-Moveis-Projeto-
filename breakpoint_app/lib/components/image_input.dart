import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({required this.onSelectImage, super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _image;

  _takePicture() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      ) as XFile;

      if (imageFile != null) {
        setState(() {
          _image = imageFile;
          widget.onSelectImage(File(_image!.path));
        });
      }
      } catch (e) {
        print(e);
      }
    }

    _chooseFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile imageFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      ) as XFile;

      if (imageFile != null) {
        setState(() {
          _image = imageFile;
          widget.onSelectImage(File(_image!.path));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _image == null
            ? SizedBox(
                width: 40,
                height: 40,
              )
            : Image.file(File(_image!.path), width: 55, height: 55),
        PopupMenuButton(
          icon: Icon(Icons.add_photo_alternate_outlined),
          onSelected: (String choice) {
                if (choice == 'camera') {
                  _takePicture();
                } else if (choice == 'gallery') {
                  _chooseFromGallery();
                }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'camera',
              child: Row(
                children: [
                  Icon(Icons.camera, color: Colors.blue),
                  SizedBox(width: 10),
                  Text('Usar Câmera'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'gallery',
              child: Row(
                children: [
                  Icon(Icons.photo_library_rounded, color: Colors.green),
                  SizedBox(width: 10),
                  Text('Escolher da Galeria'),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
