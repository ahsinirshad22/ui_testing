import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  Function(String title, double calries) onAdd;

  AddItemDialog(this.onAdd, {super.key});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _doubleFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    _doubleFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(labelText: 'Text'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _doubleFieldController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Double'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_textFieldController.text.trim().isNotEmpty &&
                _doubleFieldController.text.trim().isNotEmpty) {
              double calories = 0.0;
              try {
                calories = double.parse(_doubleFieldController.text.trim());
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Enter a valid number in calories'),
                  duration: Duration(seconds: 2),
                ));
                return;
              }
              // Both fields are not empty, perform your action here
              widget.onAdd(_textFieldController.text.trim(), calories);
              Navigator.of(context).pop();
            } else {
              // Show error message or handle empty fields
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Both fields are required.'),
                duration: Duration(seconds: 2),
              ));
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
