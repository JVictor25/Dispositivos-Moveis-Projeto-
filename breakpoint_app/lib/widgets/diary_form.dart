import 'dart:io';

import 'package:breakpoint_app/components/image_input.dart';
import 'package:breakpoint_app/data/data.dart';
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
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bodyController = TextEditingController();
  String? _selectedEmotion;

  File? _image;

  void _selectImage(File image) {
    _image = image;
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(microseconds: 500), 
      curve: Curves.easeInOut,
    );
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
      diaryProvider.addEntry(DiaryEntry(
        title: "Nova entrada",
        text: _bodyController.text,
        emotion: _selectedEmotion ?? '',
        createdAt: DateTime.now(),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildEmotionSelectionStep(),
            _buildTextInputStep(),
          ],
        ),
      )
    );
  }

  Widget _buildEmotionSelectionStep(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Como você se sente hoje?", style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 20),
        Wrap(
          spacing: 12,
          children: emotionEmojis.entries.map<Widget>((entry) {
            final emotion = entry.key;
            final emoji = entry.value;
            final isSelected = _selectedEmotion == emotion;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedEmotion = emotion;
                });
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: isSelected ? Colors.blue.shade200 : Colors.grey.shade200,
                    child: Center(child: Text(emoji, style: TextStyle(fontSize: 30))),
                  ),
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(emotion)
                    )
                ],
              ),
            );
          }).toList()
        ),
        SizedBox(height: 20),
        IconButton.filled(
          icon: const Icon(Icons.chevron_right_outlined),
          color: Colors.white,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(19, 75, 112, 1),
            ),
          ),
          onPressed: () {
          _nextPage();
          },
        )
      ],
    );
  }

  Widget _buildTextInputStep(){
    final diaryProvider = Provider.of<DiaryProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Como você se sente hoje?", style: Theme.of(context).textTheme.labelLarge),
            // SizedBox(height: 20),
            TextFormField(
              controller: _bodyController,
              maxLines: 7,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um texto';
                }
                return null;
              },
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
            ImageInput(onSelectImage: this._selectImage),
            IconButton.filled(
              icon: const Icon(Icons.check),
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(19, 75, 112, 1),
                ),
              ),
              onPressed: () {
                _saveEntry();
              },
            ),

          ],
        ),
    );
  }

}