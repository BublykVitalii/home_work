import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/features/user/cubit/user_cubit.dart';
import 'package:user_manager/models/car.dart';
import 'package:user_manager/models/user.dart';
import 'package:user_manager/models/user_service.dart';
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
  late final List<User> users;
  UserCubit get userCubit => BlocProvider.of<UserCubit>(context);
  @override
  void initState() {
    userCubit.getUsers();
    userCars = userCubit.getListCarUser(); //.userService.getListCars();

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
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return SafeArea(
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
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    //userCubit.deleteCarUser();
                                  }, //=> onPressed(user),
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            )
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
          );
        },
      ),
    );
  }
}
