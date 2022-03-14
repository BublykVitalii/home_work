import 'package:flutter/material.dart';
import 'package:user_manager/class/car.dart';

import 'package:user_manager/class/user_service.dart';
import 'package:user_manager/widgets/drawer_menu_widget.dart';

class UserCars extends StatefulWidget {
  final UserService userService;

  const UserCars({
    Key? key,
    required this.userService,
  }) : super(key: key);
  static const _routeName = '/user_cars';

  static MaterialPageRoute getRoute(UserService userService) {
    return MaterialPageRoute<Object>(
      settings: const RouteSettings(name: _routeName),
      builder: (_) => UserCars(
        userService: userService,
      ),
    );
  }

  @override
  State<UserCars> createState() => _UserCarsState();
}

class _UserCarsState extends State<UserCars> {
  List<Car> userCars = [];
  @override
  void initState() {
    userCars = widget.userService.getListCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(
        userService: widget.userService,
      ),
      appBar: AppBar(
        title: const Text('User Cars'),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final car = userCars[index]; //
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
