import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/providers/diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryForm extends StatefulWidget {
 
  DiaryForm({super.key});

  @override
  State<DiaryForm> createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);

    return Container(
      padding: EdgeInsets.all(16),
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
              hintStyle: Theme.of(context).textTheme.bodyMedium
            ),
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 14,
                color: Colors.black87,
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
            onPressed: () {diaryProvider.addEntry(DiaryEntry(
              title: "Nova entrada",
              text: _bodyController.text,
              emotion: "Feliz",
              createdAt: DateTime.now(),
            ));
            Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}