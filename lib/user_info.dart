import 'package:flutter/material.dart';
import 'package:user_manager/main.dart';
import 'package:user_manager/user_service.dart';

import 'user.dart';

class UserInfo extends StatefulWidget {
  final User user;

  const UserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User info'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/image.png'),
            ),
            TextWidget(title: widget.user.fullName),
            const LineContainer(),
            TextWidget(
              title: 'Number phone ',
              text: '+${widget.user.phone}',
            ),
            const LineContainer(),
            TextWidget(
              title: 'Age ',
              text: '${widget.user.age}',
            ),
            const LineContainer(),
            TextWidget(
              title: 'Height ',
              text: '${widget.user.height}',
            ),
            const LineContainer(),
            TextWidget(
              title: 'Weight ',
              text: '${widget.user.weight}',
            ),
            const LineContainer(),
            TextWidget(
              title: 'Sex ',
              text: '${widget.user.sex.name}',
            ),
            const LineContainer(),
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final car = widget.user.cars[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: 'Name car:',
                            text: ' ${car.name}',
                          ),
                          TextWidget(
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black54,
                  );
                },
                itemCount: widget.user.cars.length,
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
          builder: (BuildContext context) => AddCars(
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

class LineContainer extends StatelessWidget {
  const LineContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 2,
      color: Colors.grey.shade400,
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.title,
    this.text,
  }) : super(key: key);

  final String title;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '$title',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (text != null) ...{
          Text(
            text!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        },
      ],
    );
  }
}

class AddCars extends StatelessWidget {
  String nameCar = '';
  String colorCar = '';
  final ValueChanged<Car> onAdd;
  AddCars({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                nameCar = text;
              },
              decoration: const InputDecoration(
                label: Text('Name car'),
              ),
            ),
            TextField(
              onChanged: (text) {
                colorCar = text;
              },
              decoration: const InputDecoration(
                label: Text('Color car'),
              ),
            ),
          ],
        ),
      ),
      title: const Center(
        child: Text('Add cars'),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            onAdd(Car(name: nameCar, color: colorCar));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
