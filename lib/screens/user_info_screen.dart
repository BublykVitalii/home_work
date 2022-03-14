import 'package:flutter/material.dart';
import 'package:user_manager/class/car.dart';
import 'package:user_manager/class/user.dart';
import 'package:user_manager/class/user_service.dart';
import 'package:user_manager/widgets/user_info_add_dialog_widget.dart';
import 'package:user_manager/widgets/user_info_drop_down_widget.dart';
import 'package:user_manager/widgets/user_info_text_field_widget.dart';
import 'package:user_manager/widgets/user_info_text_widget.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;
  final ValueChanged<User> onUpdate;
  final UserService service;

  const UserInfoScreen({
    Key? key,
    required this.user,
    required this.onUpdate,
    required this.service,
  }) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String firstName = '';
  String lastName = '';
  String? phone;
  int? age;
  double? height;
  double? weight;
  Sex? sex;
  List<Car>? cars;

  @override
  void initState() {
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    age = widget.user.age;
    phone = widget.user.phone;
    height = widget.user.height;
    weight = widget.user.weight;
    cars = widget.user.cars;
    sex = widget.user.sex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              widget.onUpdate(
                User(
                  firstName: firstName,
                  lastName: lastName,
                  age: age,
                  phone: phone,
                  height: height,
                  weight: weight,
                  cars: cars,
                  sex: sex,
                  id: widget.user.id,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/image.png'),
            ),
            UserInfoTextFieldWidget(
              onChangedText: (value) {
                firstName = value;
              },
              initialText: firstName,
              textHint: 'name',
            ),
            UserInfoTextFieldWidget(
              onChangedText: (value) {
                lastName = value;
              },
              initialText: lastName,
              textHint: 'name',
            ),
            UserInfoTextFieldWidget(
              onChangedText: (value) => phone = value,
              initialText: widget.user.phone,
              textHint: 'number phone',
            ),
            UserInfoTextFieldWidget(
              onChangedText: (value) => age = int.tryParse(value),
              initialText: widget.user.age,
              textHint: 'age',
            ),
            UserInfoTextFieldWidget(
              onChangedText: (value) => height = double.tryParse(value),
              initialText: widget.user.height,
              textHint: 'height',
            ),
            UserInfoTextFieldWidget(
              onChangedText: (value) => weight = double.tryParse(value),
              initialText: widget.user.weight,
              textHint: 'weight',
            ),
            UserInfoDropDown(
              initValue: sex,
              onChangedSex: (Sex value) => sex = value,
            ), // save update enum
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final car = widget.user.cars?[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserInfoTextWidget(
                            title: 'Name car:',
                            text: ' ${car?.name}',
                          ),
                          UserInfoTextWidget(
                            title: 'Color car:',
                            text: ' ${car?.color}',
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => widget.user.deleteCar(car!));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black54,
                  );
                },
                itemCount: widget.user.cars?.length ?? 0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => UserInfoAddDialog(
            onAdd: (car) {
              setState(
                () => widget.user.addCar(car),
              );
            },
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
