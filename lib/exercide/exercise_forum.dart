import 'package:flutter/material.dart';




class AddExerciseForm extends StatefulWidget {
  final Function(String) onAdd;

  AddExerciseForm({required this.onAdd});

  @override
  _AddExerciseFormState createState() => _AddExerciseFormState();
}

class _AddExerciseFormState extends State<AddExerciseForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Exercise Name'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onAdd(_controller.text);
              _controller.clear();
            }
          },
          child: Text('Add Exercise'),
        ),
      ],
    );
  }
}