import 'dart:convert';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdf_editor/views/components/signblock.dart';

class Step3 extends StatefulWidget {
  final documents;

  Step3({this.documents});

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  loadImage(document) {
    return Image.memory(document.bytes);
  }

  loadTrail({
    required List<PlatformFile> documents,
    required Function onClick,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (var i = 0; i < documents.length; i++)
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(8),
              // height: 30,
              child: Column(
                children: [
                  Image.memory(documents[i].bytes!, height: 80),
                  Text('Page ${i + 1}'),
                  // loadImage(document),
                ],
              ),
            ),
            onTap: () => onClick(documents[i]),
          ),
      ]),
    );
  }

  PlatformFile? selectedDocument;

  setSelectedDocument(document) {
    setState(() {
      selectedDocument = document;
    });
  }

  loadSignatures(signatures) {
    var list = [];

    return Stack(children: [
      for (var signture in signatures)
        Image.memory(signture.bytes!, height: 50),
    ]);
  }

  bool isNewSign = false;

  renderDocument({
    document,
    signatures,
    isNewSign,
  }) {
    if (document != null) {
      return Stack(
        children: [
          Image.memory(document.bytes!),
          loadSignatures(signatures),
          isNewSign
              ? SignBlock()
              : Container(),
        ],
      );
    } else {
      return Text('Select page');
    }
  }

  setIsNewSign(value) {
    setState(() {
      isNewSign = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(widget.documents.length > 0) {
      setSelectedDocument(widget.documents[0]);
    }

    return Column(
      children: [
        const Text('Step 3'),
        loadTrail(
          documents: widget.documents,
          onClick: (document) => setSelectedDocument(document),
        ),
        renderDocument(
          document: selectedDocument,
          signatures: [],
          isNewSign: isNewSign,
        ),
        ElevatedButton(
            onPressed: () => {setIsNewSign(!isNewSign)},
            child: Text(isNewSign ? 'Cancel' : 'Sign Now'))
      ],
    );
  }
}
