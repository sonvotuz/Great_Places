import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 100,
        height: 100,
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
          onPressed: () {},
        ),
      ),
    ]);
  }
}
