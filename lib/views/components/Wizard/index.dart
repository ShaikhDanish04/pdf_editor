import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdf_editor/views/components/Wizard/Step1.dart';
import 'package:pdf_editor/views/components/Wizard/Step2.dart';
import 'package:pdf_editor/views/components/Wizard/Step3.dart';

class Wizard extends StatefulWidget {
  const Wizard({super.key});

  @override
  State<Wizard> createState() => _WizardState();
}

class _WizardState extends State<Wizard> {
  var step = 1;

  List<PlatformFile> documents = [];

  loadCurrentStep() {
    if (step == 1)
      return Step1(
        documents: documents,
        onUpload: (files) {
          addDocument(files);
          setStep(2);
        },
        onNext: documents.length > 0 ? () => setStep(2) : null,
      );
    if (step == 2) return Step3(documents: documents);
    return Step2(onNext: () {
      setStep(3);
    });
    if (step == 3) {
      print('Loading Step 3');
      print(documents.map((item) => item.name).toString());
      // addDocument(documents);
      return Step3(documents: documents);
    }
  }

  addDocument(files) {
    setState(() {
      documents.addAll(files);
    });
  }

  setStep(number) {
    setState(() {
      step = number;
    });
  }

  wizardItems() {
    return Row(children: [
      ElevatedButton(
        onPressed: () => setStep(1),
        child: Text('1'),
      ),
      ElevatedButton(
        onPressed: () => setStep(2),
        child: Text('2'),
      ),
      ElevatedButton(
        onPressed: () => setStep(3),
        child: Text('3'),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [wizardItems(), loadCurrentStep()],
    );
  }
}
