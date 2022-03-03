import 'package:user_manager/main.dart';

import 'user.dart';

class UserService {
  final _users = <User>[
    User(
      firstName: 'Vlad',
      lastName: 'Kononenko',
      age: 25,
      cars: [
        Car(name: 'BMW', color: 'Red'),
        Car(name: 'Audi', color: 'Black'),
      ],
      height: 173,
      phone: 380661231236,
      sex: Sex.male,
      weight: 63,
    )
  ];

  List<User> get users => _users;
  void deleteUser(User user) => _users.remove(user);
  void addUser(User user) => _users.add(user);

  // List<User> get addUser =>
  //     users..add(User(firstName: firstName, lastName: lastName));

}
