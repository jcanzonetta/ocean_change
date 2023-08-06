import 'package:flutter/material.dart';

import '../../models/user_report.dart';

class WaterColorFormField extends StatefulWidget {
  const WaterColorFormField({super.key, required this.userReport});

  final UserReport userReport;
  static const colors = {
    'Blue (clear)': Color.fromARGB(255, 9, 195, 219),
    'Coffee-brown (coffee with milk)': Color.fromARGB(255, 139, 94, 69),
    'Dark Brown (black coffee)': Color.fromARGB(255, 109, 58, 52),
    'Green': Color.fromARGB(255, 88, 168, 148),
    'Red': Colors.red,
    'Something else': Colors.transparent,
  };

  @override
  State<WaterColorFormField> createState() => _WaterColorFormFieldState();
}

class _WaterColorFormFieldState extends State<WaterColorFormField> {
  final colorsList = WaterColorFormField.colors.keys.toList();

  @override
  void initState() {
    super.initState();
    widget.userReport.waterColor = colorsList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Water color: '),
        Expanded(
          child: DropdownButton<String>(
              isExpanded: true,
              value: widget.userReport.waterColor,
              items: getDropDownMenuItems(colorsList),
              selectedItemBuilder: (context) {
                return colorsList
                    .map((e) => Center(
                          child: Text(
                            widget.userReport.waterColor!,
                            style: TextStyle(
                                backgroundColor: WaterColorFormField.colors[e]),
                          ),
                        ))
                    .toList();
              },
              onChanged: (String? value) {
                setState(() {
                  widget.userReport.waterColor = value;
                });
              }),
        ),
      ],
    );
  }

  getDropDownMenuItems(List colors) {
    List<DropdownMenuItem<String>> dropDownList = [];

    for (final color in colors) {
      dropDownList.add(DropdownMenuItem(
        value: color,
        child: Text(color),
      ));
    }

    return dropDownList;
  }
}
