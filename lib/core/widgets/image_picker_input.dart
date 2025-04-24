import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerInputField extends StatefulWidget {
  const ImagePickerInputField({
    super.key,
    required this.onImageSelected,
  });

  final Function(File?) onImageSelected;

  @override
  State<ImagePickerInputField> createState() => _ImagePickerInputFieldState();
}

class _ImagePickerInputFieldState extends State<ImagePickerInputField> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    } else {
      widget.onImageSelected(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _selectedImage != null
            ? Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    _selectedImage!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 15,
                  child: GestureDetector(
                      onTap: () {
                        _selectedImage = null;
                        setState(() {});
                      },
                      child: Icon(Icons.delete_forever)),
                )
              ])
            : Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: const Center(
                  child: Text(
                    'No Image Selected',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }
}
