import 'package:user_manager/user.dart';

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

    // _users
    //   ..remove(specificUser)
    //   ..add(user);
    _users.replaceRange(userIndex, userIndex + 1, [user]);
  }

  List<Car> getListCars() {
    // List<Car> biba = [];
    // _users.forEach((user) {
    //   final cars = user.cars ?? [];
    //   biba.addAll(cars);
    // });
    // print(biba.first.name);
    // return biba;
    List<Car> listCars = [];
    for (var n in _users) {
      // listCars.addAll(n.cars ?? []);
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
