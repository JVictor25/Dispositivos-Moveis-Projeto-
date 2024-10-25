import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViceForm extends StatefulWidget {
  final void Function(String, DateTime, String) onSubmit;
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
  DateTime _dataSelecionada = DateTime.now();
  String _selectedViceType =
      'general'; // 'general' para vícios em geral, 'specific' para específicos

  List<String> _viceTypes = [
    'Geral',
    'Alcool',
    'Fumo',
    'Jogos de Azar',
    'Comida',
    'Drogas',
    'Tecnologia',
    'Trabalho',
    'Relacionamentos'
  ];
  void _submitForm() {
    if (_vice.text.isEmpty || _dataSelecionada == null) {
      return; // Verifica se os campos obrigatórios estão preenchidos
    }

    widget.onSubmit(
      _vice.text,
      _dataSelecionada,
      _selectedViceType,
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
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dataSelecionada == null
                            ? 'Nenhuma data selecionada'
                            : 'Data selecionada: ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text('Selecionar Data'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Tipo de Vício',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color(0xFF134B70),
                    width: 2.0,
                  ),
                ),
              ),
              items: _viceTypes.map((String type) {
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
