import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImage extends StatelessWidget {
  const GetImage({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Photo de profil",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Container(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                  child: IconButton(
                onPressed: () async {
                  final result =
                      await picker.pickImage(source: ImageSource.camera);

                  Navigator.of(context).pop(File(result!.path));
                },
                icon: const Icon(Icons.camera_alt),
              )),
              Container(
                width: 10,
              ),
              CircleAvatar(
                  child: IconButton(
                onPressed: () async {
                  final result =
                      await picker.pickImage(source: ImageSource.gallery);

                  Navigator.of(context).pop(result);
                },
                icon: const Icon(Icons.image),
              ))
            ],
          )
        ],
      ),
    );
  }
}
