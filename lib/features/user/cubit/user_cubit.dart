import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_manager/models/car.dart';
import 'package:user_manager/models/user.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  // List<Car> _listCars = [];
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

  void getUsers() {
    //final successState = state as UserSuccess;
    emit(UserLoading());
    print('state:$state');
    Future.delayed(const Duration(seconds: 2), () {
      print('Hello world');
      emit(UserSuccess(users: _users, cars: []));
      //print('state2:${successState.users}');
    });
  }

  void deleteUser(User user) {
    emit(UserLoading());
    _users.remove(user);
    print('>>>>>$user');
    Future.delayed(const Duration(seconds: 2), () {
      print('loading delete  user');
      emit(UserSuccess(users: _users, cars: []));
      print(' $deleteUser');
    });
  }

  void addUser(User user) {
    emit(UserLoading());
    _users.add(user);
    Future.delayed(const Duration(seconds: 2), () {
      print('loading add user');
      emit(UserSuccess(users: _users, cars: []));
      print(' user add');
    });
  }

  void updateUser(User user) {
    final state = this.state;
    List<Car>? listCars = [];
    if (state is UserSuccess) {
      listCars = state.cars;
    }
    emit(UserLoading());
    final userIndex = _users.indexWhere(
      (specificUser) {
        return user.id == specificUser.id;
      },
    );
    _users.replaceRange(userIndex, userIndex + 1, [user]);
    Future.delayed(const Duration(seconds: 2), () {
      print('loading for update');
      emit(UserSuccess(users: _users, cars: listCars));
    });

    print(' user update');
  }

  List<Car> getListCarUser() {
    emit(UserLoading());
    List<Car> listCars = [];

    for (var user in _users) {
      List<Car> cars = user.cars ?? [];
      if (cars.isNotEmpty) {
        for (var car in cars) {
          listCars.add(
            Car(
              owner: user.fullName,
              name: car.name,
              color: car.color,
              ownerId: user.id,
            ),
          );
        }
      }
    }
    Future.delayed(const Duration(seconds: 2), () {
      print('loading for update list car');
      emit(UserSuccess(users: _users, cars: listCars));
      print(' List car update');
    });

    return listCars;
  }

  // void deleteCarUser(Car car) {
  //   emit(UserLoading());
  //   final User user = _users.firstWhere((user) => user.id == car.ownerId);
  //   final cars = user.cars?..remove(car);
  //   Future.delayed(const Duration(seconds: 2), () {
  //     print('loading delete  car user');
  //     emit(UserSuccess(users: _users, cars: _listCars));
  //     print('${cars?.length}');
  //     print(' delete car ');
  //   });
  // }

  void deleteUserCar(Car car) {
    final state = this.state;
    List<Car>? listCars = [];
    if (state is UserSuccess) {
      listCars = state.cars;
    }
    emit(UserLoading());

    listCars?.remove(car);
    Future.delayed(const Duration(seconds: 1), () {
      print('loading delete  user');
      emit(UserSuccess(users: _users, cars: listCars));
      // final User user = _users.firstWhere((user) => user.id == car.ownerId);
      // final updatedUser = User(
      //   firstName: user.firstName,
      //   lastName: user.lastName,
      //   age: user.age,
      //   phone: user.phone,
      //   height: user.height,
      //   weight: user.weight,
      //   cars: listCars,// изменить
      //   sex: user.sex,
      //   id: user.id,
      // );
      // updateUser(updatedUser);
      print(' delete user car');
    });
  }
}
