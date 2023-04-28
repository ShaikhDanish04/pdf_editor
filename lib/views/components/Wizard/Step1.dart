import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:file_picker/file_picker.dart';

class Step1 extends StatefulWidget {
  final onNext;
  final onUpload;
  final documents;

  const Step1({
    this.onNext,
    this.onUpload,
    this.documents,
  });

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  List<PlatformFile> documents = [];

  listFiles() {
    return Column(children: [
      for (PlatformFile document in documents)
        Container(
          child: Column(
            children: [
              Text(document.name),
              // loadImage(document)
            ],
          ),
        ),
    ]);
  }

  
  loadImage(document) {
    return Image.memory(document.bytes);
  }

  @override
  Widget build(BuildContext context) {
    documents = widget.documents;

    next() {
      widget.onNext();
    }

    upload() async {
      documents = [];

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true
              // type: FileType.custom,
              // allowedExtensions: ['jpg', 'pdf', 'doc'],
              );

      var files = result?.files;

      for (var file in files!) {
        setState(() {
          documents.add(file);
        });
      }
      widget.onUpload(documents);
    }

    return Column(
      children: [
        const Text('Step 1', style: TextStyle(fontSize: 50)),
        ElevatedButton(onPressed: () => upload(), child: Text('Upload')),
        listFiles(),
        ElevatedButton(
          onPressed: widget.onNext != null ? () => next() : null,
          child: Text('Next'),
        ),
      ],
    );
  }
}
