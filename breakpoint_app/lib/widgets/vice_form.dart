// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/components/notification.dart';
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
  final List<String> _impactTypes = ['dinheiro', 'tempo', 'nao informar'];
  List<TimeOfDay>? selectedTimes = null;

  @override
  void initState() {
    super.initState();
    if (widget.existingVice != null) {
      _formData['id'] = widget.existingVice!.id;
      /*_formData['viceType'] = widget.existingVice!.viceType;
      _formData['impactType'] = widget.existingVice!.impactType;
      _formData['impactValue'] = widget.existingVice!.impactValue;
      _formData['description'] = widget.existingVice!.description;*/
      if (selectedTimes == null) {
        selectedTimes = widget.existingVice!.dangerousTimes!;
      }
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

    final provider = Provider.of<ViceProvider>(context, listen: false);
    final activeUser = Provider.of<ActiveUser>(context, listen: false);

    try {
      if (widget.existingVice != null) {
        Map<String, dynamic> form = {
          'id': widget.existingVice!.id,
          'description':
              _formData['description'] != widget.existingVice!.description
                  ? _formData['description']
                  : null,
          'addictionImpact':
              _formData['impactType'] != widget.existingVice!.impactType
                  ? _formData['impactType']
                  : null,
          'impactCost':
              _formData['impactValue'] != widget.existingVice!.impactValue
                  ? _formData['impactValue']
                  : null,
          'criticalHours': widget.existingVice!.dangerousTimes != selectedTimes
              ? selectedTimes!.map((time) {
                  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                }).toList()
              : widget.existingVice!.dangerousTimes!.map((time) {
                  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                }).toList(),
        };
        await provider.updateVice(form, activeUser.currentUser!).then((value) {
          FirebaseApi _notificationService = FirebaseApi();
          _notificationService.cancelAllNotifications();
          _notificationService
              .scheduleNotifications(provider.getDangerousTimes())
              .then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Notificações agendadas com sucesso!')),
            );
          }).catchError((e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao agendar notificações: $e')),
            );
          });
        });
      } else {
        final vice = Vice(
            id: _formData['id'] ?? Uuid().v4(),
            datesobriety: DateTime.now(),
            dateCreation: DateTime.now(),
            viceType: _formData['viceType'],
            impactType: _formData['impactType'],
            impactValue: _formData['impactValue'] ?? '',
            dangerousTimes: selectedTimes,
            description: _formData['description'],
            reseted: false);
        await provider.addVice(vice, activeUser.currentUser!).then((value) {
          FirebaseApi _notificationService = FirebaseApi();
          _notificationService.cancelAllNotifications();
          _notificationService
              .scheduleNotifications(provider.getDangerousTimes())
              .then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Notificações agendadas com sucesso!')),
            );
          }).catchError((e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao agendar notificações: $e')),
            );
          });
        });
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

  Widget _showViceType(BuildContext context) {
    return DropdownButtonFormField<String>(
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
      value: _formData['viceType'],
      items: viceType.map((String type) {
        return DropdownMenuItem<String>(
          value: type.toLowerCase(),
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
    );
  }

  Widget _showImpactValue(BuildContext context) {
    return TextFormField(
      initialValue: _formData['impactValue']?.toString(),
      decoration: InputDecoration(
        labelText: "Valor",
        hintText: "Quanto você gasta por dia?",
        hintStyle: TextStyle(
          fontFamily: 'PoppinsRegular',
          fontSize: 14,
          color: Colors.black87,
        ),
        filled: true,
        fillColor: Color(0xffA8DADC),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Informe o seu gasto!";
        }
        return null;
      },
      onSaved: (value) {
        _formData['impactValue'] = value!;
      },
    );
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
        actions: [
          IconButton(
            icon: Icon(Icons.access_time, color: Colors.white),
            onPressed: () async {
              if (selectedTimes == null) {
                selectedTimes = [];
              }
              selectedTimes = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchTimeScreen(
                    selectedTimes: selectedTimes!,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    widget.existingVice == null
                        ? _showViceType(context)
                        : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      value: _formData['impactType'],
                      items: _impactTypes.map((type) {
                        return DropdownMenuItem(
                          value: type.toLowerCase(),
                          child: Text(type),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffA8DADC),
                        labelText: 'Tipo de impacto',
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
                      onChanged: (value) {
                        setState(() {
                          _formData['impactType'] = value!;
                        });
                      },
                      validator: (value) {
                        if (widget.existingVice != null &&
                            (value == null || value.isEmpty)) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return "Selecione um tipo de impacto!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _formData['impactType'] == "tempo"
                        ? _showImpactValue(context)
                        : _formData['impactType'] == 'dinheiro'
                            ? _showImpactValue(context)
                            : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffA8DADC),
                        labelText: 'Descrição',
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
                      maxLines: 4,
                      validator: (value) {
                        if (widget.existingVice != null &&
                            (value == null || value.isEmpty)) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return "Por favor, insira uma descrição!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _formData['description'] = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
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

class SearchTimeScreen extends StatefulWidget {
  List<TimeOfDay> selectedTimes = [];

  SearchTimeScreen({super.key, required this.selectedTimes});

  @override
  _SearchTimeScreenState createState() => _SearchTimeScreenState();
}

class _SearchTimeScreenState extends State<SearchTimeScreen> {
  void _addTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        widget.selectedTimes.add(pickedTime);
      });
    }
  }

  void _removeTime(int index) {
    setState(() {
      widget.selectedTimes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolher Horários"),
        backgroundColor: Color(0xff133E87),
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(widget.selectedTimes.isEmpty
                  ? widget.selectedTimes = []
                  : widget.selectedTimes);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _addTime,
              icon: Icon(Icons.add, color: Colors.black87),
              label: Text(
                "Adicionar Horário",
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffA8DADC),
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Horários Selecionados:",
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: widget.selectedTimes.isEmpty
                  ? Center(
                      child: Text(
                        "Nenhum horário selecionado.",
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.selectedTimes.length,
                      itemBuilder: (context, index) {
                        final time = widget.selectedTimes[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontFamily: 'PoppinsRegular',
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeTime(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, widget.selectedTimes);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xff133E87),
              ),
              child: Text(
                "Salvar Horários",
                style: TextStyle(
                  fontFamily: 'PoppinsLight',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
