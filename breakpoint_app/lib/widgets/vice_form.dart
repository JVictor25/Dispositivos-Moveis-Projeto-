// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/data/data.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import '../model/Vice.dart';
import '../providers/vice_provider.dart';

class ViceForm extends StatefulWidget {
  final Vice? existingVice;

  const ViceForm({Key? key, this.existingVice}) : super(key: key);

  @override
  _ViceFormState createState() => _ViceFormState();
}

class _ViceFormState extends State<ViceForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  bool _isLoading = false;
  final DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _formData['datesobriety'] = DateTime.now();
    if (widget.existingVice != null) {
      _formData['id'] = widget.existingVice!.id;
      _formData['datesobriety'] = widget.existingVice!.datesobriety;
      _formData['dateCreation'] = widget.existingVice!.dateCreation;
      _formData['viceType'] = widget.existingVice!.viceType;
      /*_formData['impactType'] = widget.existingVice!.impactType;
      _formData['impactValue'] = widget.existingVice!.impactValue;*/
    }
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    final vice = Vice(
      id: _formData['id'] ?? Uuid().v4(),
      datesobriety: _formData['datesobriety'],
      dateCreation: DateTime.now(),
      viceType: _formData['viceType'],
      /*impactType: _formData['impactType'],
      impactValue: _formData['impactValue'],*/
    );

    final provider = Provider.of<ViceProvider>(context, listen: false);
    final activeUser = Provider.of<ActiveUser>(context, listen: false);

    try {
      if (widget.existingVice != null) {
        await provider.updateVice(vice, activeUser.currentUser!);
      } else {
        await provider.addVice(vice, activeUser.currentUser!);
      }
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving vice: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _showCalendar(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TableCalendar(
        focusedDay: _selectedDate,
        firstDay: DateTime(2000),
        lastDay: DateTime.now(),
        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            //_selectedDate = selectedDay;
            _formData['datesobriety'] = _selectedDate;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color(0xff133E87),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Color(0xffA8DADC),
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.existingVice != null ? "Editando Hábito" : "Novo Hábito"),
        backgroundColor: Color(0xff133E87),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffA8DADC),
                        labelText: 'Tipo de Vício',
                        labelStyle: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color(0xFF134B70),
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      items: viceType.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type
                              .toLowerCase(), // Armazena como lowercase para comparação fácil
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _formData['viceType'] = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por Favor selecione um tipo de hábito.";
                        }
                        return null;
                      },
                    ),
                    /*DropdownButtonFormField<String>(
                      value: _formData['impactType'],
                      items: _impactTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: "Impact Type",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _formData['impactType'] = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select an impact type.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['impactValue']?.toString(),
                      decoration: InputDecoration(labelText: "Impact Value"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formData['impactValue'] = value!;
                      },
                    ),*/
                    _showCalendar(context),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Color(0xffA8DADC)),
                      onPressed: _submitForm,
                      child: Text(
                        widget.existingVice != null
                            ? "Editar hábito"
                            : "Adicionar hábito",
                        style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
