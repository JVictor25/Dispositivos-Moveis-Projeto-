// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:breakpoint_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViceForm extends StatefulWidget {
  final void Function(String, DateTime, String, String, dynamic) onSubmit; // Atualizado para incluir novos atributos
  final bool isModifying;

  const ViceForm({
    super.key,
    required this.onSubmit,
    required this.isModifying,
  });

  @override
  State<ViceForm> createState() => _ViceFormState();
}

class _ViceFormState extends State<ViceForm> {
  final TextEditingController _vice = TextEditingController();
  final TextEditingController _impactValueController = TextEditingController();
  DateTime? _dataSelecionada;
  String _selectedViceType =
      'general'; // 'general' para vícios em geral, 'specific' para específicos
  String _selectedImpactType =
      'none'; // Inicializa como "nenhum impacto"

  void _submitForm() {
    if (_vice.text.isEmpty || _dataSelecionada == null) {
      return;
    }

  dynamic impactValue;
    if (_selectedImpactType == 'money' || _selectedImpactType == 'time') {
      impactValue = double.tryParse(_impactValueController.text);
    } else {
      impactValue = null; // Para casos onde o impacto não é calculável
    }

    widget.onSubmit(
      _vice.text,
      _dataSelecionada!,
      _selectedViceType,
      _selectedImpactType,
      impactValue,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _dataSelecionada = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Cadastre seu vício:",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _vice,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color(0xFF134B70),
                    width: 2.0,
                  ),
                ),
                filled: true,
                hintText: "Qual o seu vício?",
                hintStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Tipo de Vício',
                labelStyle: Theme.of(context).textTheme.bodySmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color(0xFF134B70),
                    width: 2.0,
                  ),
                ),
              ),
              style: TextStyle(
                fontFamily: 'roboto',
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
              onChanged: (String? newValue) {
                setState(() {
                  _selectedViceType = newValue ?? 'general';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, selecione um tipo de vício';
                }
                return null;
              },
            ),
             SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Tipo de Impacto',
                labelStyle: Theme.of(context).textTheme.bodySmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  
                  borderSide: BorderSide(
                    color: Color(0xFF134B70),
                    width: 2.0,
                  ),
                ),
              ),
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 14,
                color: Colors.black87,
              ),
              items: ['none', 'money', 'time'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type == 'none'
                      ? 'Não calculável'
                      : type == 'money'
                          ? 'Dinheiro perdido por semana (R\$)'
                          : 'Horas perdidas por dia'),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedImpactType = newValue ?? 'none';
                });
              },
            ),
            if (_selectedImpactType != 'none') ...[
              SizedBox(height: 16),
              TextField(
                controller: _impactValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true, // Ativa o preenchimento do campo
                 // fillColor: const Color.fromARGB(255, 230, 230, 230), // Define o fundo branco
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Color(0xFF134B70),
                      width: 2.0,
                    ),
                  ),
                  hintText: _selectedImpactType == 'money'
                      ? 'Valor perdido por semana (ex: 100.50)'
                      : 'Horas perdidas por dia (ex: 3)',
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                ),
                //style: TextStyle(
                //  fontFamily: 'roboto',
                //  fontSize: 14,
//color: Colors.black87,
               // ),
              ),
            ],
            SizedBox(height: 16),
            Text(
              "Última vez que praticou:",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showDatePicker();
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xFF134B70),
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        _dataSelecionada == null
                            ? 'Selecionar data'
                            : DateFormat('dd/MM/yyyy')
                                .format(_dataSelecionada!),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitForm(),
              child: Text(widget.isModifying ? "Modificar" : "Adicionar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF134B70),
                foregroundColor: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF134B70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
