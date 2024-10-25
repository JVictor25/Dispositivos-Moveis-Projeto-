import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViceForm extends StatefulWidget {
  final void Function(String, DateTime) onSubmit;
  final bool isModifying;

  const ViceForm ({
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
  

  void _submitForm() {
    String _typeofvice = _vice.text;


    if (_typeofvice.isEmpty ) {
      return; // Verifica se os campos obrigatórios estão preenchidos
    }

    widget.onSubmit(
      _typeofvice,
      _dataSelecionada,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020, 1, 1),
            lastDate: DateTime.now())
        .then((pickedDate) {
      //chamada no futuro
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Campo para o título da tarefa
            Text(
              "Cadastre seu vício: ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _vice,
              decoration: InputDecoration(
                hintText: "Qual o seu vicio?",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 16),
        
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      _dataSelecionada == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_dataSelecionada)}',
                    ),
                  ),
                  TextButton(
                      //style: TextButton.styleFrom(primary: Colors.blue),
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                      ))
                ]),
              ),
            ),
            Column(children: [
              ElevatedButton(
                onPressed: () => _submitForm(),
                child: Text(widget.isModifying ? "Modificar" : "Adicionar"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Voltar',
                  style: TextStyle(color: Colors.blue, fontSize: 11),
                ),
              ),
            ]),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
