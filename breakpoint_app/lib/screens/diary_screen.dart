// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/widgets/diary_list.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/widgets/diary_form.dart';


class DiaryScreen extends StatefulWidget {

  DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  
  void _openDiaryForm() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(child: DiaryForm()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiaryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDiaryForm,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF134B70),
        foregroundColor: Colors.white,
      ),
    );
  }
}
