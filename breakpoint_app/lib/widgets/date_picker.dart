import 'package:flutter/material.dart';

class MonthPicker extends StatefulWidget {
  MonthPicker(
      {
      required this.onDateSelected,
      required this.initialYear,
      required this.startYear,
      required this.endYear,
      this.currentYear,
      required this.month,
      Key? key})
      : super(key: key);
  late int initialYear;
  late int startYear;
  late int endYear;
  late int? currentYear;
  late int month;
  final Function(int month, int year) onDateSelected;
  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  final List<String> _monthList = [
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro"
];
  List<String> _yearList = [];
  late int selectedMonthIndex;
  late int selectedYearIndex;
  String selectedMonth = "";
  String selectedYear = "";
  @override
  void initState() {
    for (int i = widget.startYear; i <= widget.endYear; i++) {
      _yearList.add(i.toString());
    }
    selectedMonthIndex = widget.month - 1;
    selectedYearIndex = _yearList.indexOf(
        widget.currentYear?.toString() ?? widget.initialYear.toString());
    // Inicializando os valores selecionados
    selectedMonth = _monthList[selectedMonthIndex];
    selectedYear = _yearList[selectedYearIndex];
    super.initState();
  }

  void _notifyDateSelected() {
    final selectedMonthIndex = _monthList.indexOf(selectedMonth) + 1;
    final selectedYearValue = int.parse(selectedYear);

    widget.onDateSelected(selectedMonthIndex, selectedYearValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  items: _monthList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: 17)),
                    );
                  }).toList(),
                  value: selectedMonth,
                  onChanged: (val) {
                    setState(() {
                      selectedMonthIndex = _monthList.indexOf(val!);
                      selectedMonth = val;
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  items: _yearList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: 20),),
                    );
                  }).toList(),
                  value: selectedYear,
                  onChanged: (val) {
                    setState(() {
                      selectedYear = val!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    _notifyDateSelected();
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text(
                    "OK",
                  ))
            ],
          )
        ],
      ),
    );
  }
}