import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Step2 extends StatefulWidget {
  var onNext;

  Step2({this.onNext});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  @override
  Widget build(BuildContext context) {
    next() {
      widget.onNext();
    }


    return Column(
      children: [
        const Text('Step 2'),
        ElevatedButton(
          onPressed: widget.onNext != null ? () => next() : null,
          child: Text('Next'),
        ),
      ],
    );
  }
}
