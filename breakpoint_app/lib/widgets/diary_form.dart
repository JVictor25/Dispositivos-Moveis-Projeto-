import 'package:flutter/material.dart';

class DiaryForm extends StatelessWidget {
  final void Function(String) onSubmit;
 
  DiaryForm({super.key, required this.onSubmit});

  final TextEditingController _bodyController = TextEditingController();

  void _submitForm(BuildContext context) {
    final body = _bodyController.text;

    if (body.isEmpty) {
      return;
    }

    onSubmit(body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Como você se sente hoje?", style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: 20),
          TextField(
            controller: _bodyController,
            maxLines: 7,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(128, 196, 233, 0.2),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(128, 196, 233, 1)),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(19, 75, 112, 1), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Hoje eu...',
            ),
          ),
          SizedBox(height: 20),
          IconButton.filled(
            icon: const Icon(Icons.check),
            color: Colors.white,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(19, 75, 112, 1),
              ),
            ),
            onPressed: () => _submitForm(context),
          )
        ],
      ),
    );
  }
}