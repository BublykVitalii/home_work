import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_manager/models/car.dart';
import 'package:user_manager/models/user.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
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
      emit(UserSuccess(users: _users));
      //print('state2:${successState.users}');
    });
  }

  void deleteUser(User user) {
    emit(UserLoading());
    _users.remove(user);
    print('>>>>>$user');
    Future.delayed(const Duration(seconds: 2), () {
      print('loading delete  user');
      emit(UserSuccess(users: _users));
      print(' $deleteUser');
    });
  }

  void addUser(User user) {
    emit(UserLoading());
    _users.add(user);
    Future.delayed(const Duration(seconds: 2), () {
      print('loading add user');
      emit(UserSuccess(users: _users));
      print(' user add');
    });
  }

  void updateUser(User user) {
    emit(UserLoading());
    final userIndex = _users.indexWhere(
      (specificUser) {
        return user.id == specificUser.id;
      },
    );
    _users.replaceRange(userIndex, userIndex + 1, [user]);
    Future.delayed(const Duration(seconds: 2), () {
      print('loading for update');
      emit(UserSuccess(users: _users));
    });

    print(' user update');
  }

  List<Car> getListCarUser() {
    emit(UserLoading());
    List<Car> listCars = [];
    for (var n in _users) {
      final cars = n.cars ?? [];
      for (var car in cars) {
        listCars.add(
          Car(owner: n.fullName, name: car.name, color: car.color),
        );
      }
    }
    Future.delayed(const Duration(seconds: 2), () {
      print('loading for update list car');
      emit(UserSuccess(users: _users));
      print(' List car update');
    });

    return listCars;
  }

  void deleteCarUser(User user) {
    emit(UserLoading());
    _users.remove(user.cars);
    Future.delayed(const Duration(seconds: 2), () {
      print('loading delete user');
      emit(UserSuccess(users: _users));
      print(' delete car ');
    });
  }
}
