import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/features/user/cubit/user_cubit.dart';
import 'package:user_manager/models/car.dart';
import 'package:user_manager/models/user.dart';

import 'package:user_manager/widgets/user_info_add_dialog_widget.dart';
import 'package:user_manager/widgets/user_info_drop_down_widget.dart';
import 'package:user_manager/widgets/user_info_text_field_widget.dart';
import 'package:user_manager/widgets/user_info_text_widget.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;

  const UserInfoScreen({
    Key? key,
    required this.user,
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
  late List<Car> cars;

  UserCubit get userCubit => BlocProvider.of<UserCubit>(context);

  @override
  void initState() {
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    age = widget.user.age;
    phone = widget.user.phone;
    height = widget.user.height;
    weight = widget.user.weight;
    cars = widget.user.cars ?? [];
    sex = widget.user.sex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('User info'),
            actions: [
              if (state is UserLoading) ...{
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              },
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  final updatedUser = User(
                    firstName: firstName,
                    lastName: lastName,
                    age: age,
                    phone: phone,
                    height: height,
                    weight: weight,
                    cars: cars,
                    sex: sex,
                    id: widget.user.id,
                  );
                  userCubit.updateUser(updatedUser);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
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
                  ),
                  Column(
                    children: [
                      for (var car in cars) ...{
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserInfoTextWidget(
                                  title: 'Name car:',
                                  text: ' ${car.name}',
                                ),
                                UserInfoTextWidget(
                                  title: 'Color car:',
                                  text: ' ${car.color}',
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() => widget.user.deleteCar(car));
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black54,
                        ),
                      }
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
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
      },
    );
  }
}
