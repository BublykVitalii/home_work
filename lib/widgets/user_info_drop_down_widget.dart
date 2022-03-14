import 'package:flutter/material.dart';
import 'package:user_manager/class/user.dart';

class UserInfoDropDown extends StatefulWidget {
  const UserInfoDropDown({
    Key? key,
    required this.initValue,
    required this.onChangedSex,
  }) : super(key: key);
  final Sex? initValue;
  final ValueChanged<Sex> onChangedSex;
  @override
  _UserInfoDropDownState createState() => _UserInfoDropDownState();
}

class _UserInfoDropDownState extends State<UserInfoDropDown> {
  Sex? dropDownValue;
  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      dropDownValue = widget.initValue;
    }
  }

  var items = [
    Sex.female,
    Sex.male,
    Sex.other,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: DropdownButton<Sex>(
        isExpanded: true,
        value: dropDownValue ?? Sex.other,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((Sex item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              User.parseEnumToString(item),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            dropDownValue = newValue;
          });
          widget.onChangedSex(newValue!);
        },
      ),
    );
  }
}
