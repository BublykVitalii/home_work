import 'package:flutter/material.dart';

import 'package:user_manager/user.dart';

class UserCars extends StatelessWidget {
  final List<Car> userCars;
  const UserCars({
    Key? key,
    required this.userCars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        title: const Text('User Cars'),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final car = userCars[index];
            return ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: Image.asset('assets/images/image.png'),
              ),
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${car.name}'),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_box,
                          color: Colors.grey,
                        ),
                        Text(
                          '${car.owner}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: userCars.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
