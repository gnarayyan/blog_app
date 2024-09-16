import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({
    super.key,
    required this.labelText,
    required this.setImage,
  });
  final String labelText;
  final void Function(File?) setImage;

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  String? fileName;
  File? file;

  Future<void> _uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      List<PlatformFile> files = result.files;

      setState(() {
        if (files.isNotEmpty && files.first.path != null) {
          file = File(files.first.path!);
          fileName = files.first.name;

          widget.setImage(file);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelText =
        fileName == null ? widget.labelText : 'Change ${widget.labelText}';
    final validationText = '${widget.labelText} is Required';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: _uploadImage,
          child: Text(labelText, style: const TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 0, bottom: 10),
          child: Text(
            fileName ?? '',
            style: const TextStyle(
                color: Color.fromARGB(255, 113, 108, 107), fontSize: 10),
          ),
        ),
        file == null
            ? Text(
                validationText,
                style: const TextStyle(
                    color: Color.fromARGB(255, 247, 13, 28), fontSize: 10),
              )
            : Image.file(
                file!,
                height: 150,
              )
      ],
    );
  }
}
