import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignBlock extends StatefulWidget {
  const SignBlock({super.key});

  @override
  State<SignBlock> createState() => _SignBlockState();
}

class _SignBlockState extends State<SignBlock> {
  var position = [0.0, 0.0];

  setPosition(value) {
    setState(() {
      position = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position[0],
      left: position[1],
      child: Draggable(
        feedback: Container(),
        child: Container(
          height: 50,
          color: Colors.red,
          child: const AspectRatio(
            aspectRatio: 2 / 1,
          ),
        ),
        onDragUpdate: (e) {
          // print(e.localPosition);
          setPosition([
            e.localPosition.dy - 230,
            e.localPosition.dx - 0,
          ]);
        },
      ),
    );
  }
}
