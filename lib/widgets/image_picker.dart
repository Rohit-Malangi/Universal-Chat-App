import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput(this._pickedImage, {Key? key}) : super(key: key);

  void Function(File image) _pickedImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _stordImage;

  _takeImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
      maxWidth: 150,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _stordImage = File(imageFile.path);
    });
    widget._pickedImage(File(imageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _stordImage != null
              ? Image.file(
                  _stordImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No Image Taken', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: _takeImage,
          label: const Text('Take Picture'),
          icon: const Icon(Icons.camera_alt),
        )
      ],
    );
  }
}
