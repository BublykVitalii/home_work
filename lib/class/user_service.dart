import 'package:user_manager/class/car.dart';
import 'package:user_manager/class/user.dart';

class UserService {
  final _users = <User>[
    User(
      firstName: 'Vlad',
      lastName: 'Kononenko',
      age: 25,
      cars: [
        Car(name: 'BMW', color: 'Red', owner: ''),
        Car(name: 'Audi', color: 'Black', owner: ''),
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
        return user.id == specificUser.id;
      },
    );

    _users.replaceRange(userIndex, userIndex + 1, [user]);
  }

  List<Car> getListCars() {
    List<Car> listCars = [];
    for (var n in _users) {
      final cars = n.cars ?? [];
      for (var car in cars) {
        listCars.add(
          Car(owner: n.fullName, name: car.name, color: car.color),
        );
      }
    }

    return listCars;
  }
}
