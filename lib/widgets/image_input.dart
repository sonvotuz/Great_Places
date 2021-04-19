import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storeImage = File(imageFile.path);
    });
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storeImage.copy('${appDirectory.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: _storeImage != null
            ? Image.file(
                _storeImage,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text(
                'No image taken',
                textAlign: TextAlign.center,
              ),
        alignment: Alignment.center,
      ),
      SizedBox(width: 10),
      Expanded(
        child: TextButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take picture'),
          style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: _takePicture,
        ),
      ),
    ]);
  }
}
