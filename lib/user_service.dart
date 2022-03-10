import 'package:user_manager/user.dart';

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
      phone: '380661231236',
      sex: Sex.male,
      weight: 63,
      id: 1,
    )
  ];

  List<User> get users => _users;
  void deleteUser(User user) => _users.remove(user);
  void addUser(User user) => _users.add(user);
  void updatedUser(User user) {
    final userIndex = _users.indexWhere(
      (specificUser) {
        print(specificUser.id);
        return user.id == specificUser.id;
      },
    );
    print(user.id);

    // _users
    //   ..remove(specificUser)
    //   ..add(user);
    _users.replaceRange(userIndex, userIndex + 1, [user]);
  }
}
