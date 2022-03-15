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

  void removeUser(User user) {
    final removeUser = _users..remove(user);
    emit(UserLoading());
    Future.delayed(const Duration(seconds: 2), () {
      print('loading delete  user');
      emit(UserSuccess(users: removeUser));
      print(' user delete');
    });
  }

  void addUser(User user) {
    final addUser = _users..add(user);
    emit(UserLoading());
    Future.delayed(const Duration(seconds: 2), () {
      print('loading add user');
      emit(UserSuccess(users: addUser));
      print(' user add');
    });
  }

  void updateUser(User user) {
    emit(UserLoading());
    Future.delayed(const Duration(seconds: 2), () {
      print('loading for update');
    });
    final userIndex = _users.indexWhere(
      (specificUser) {
        return user.id == specificUser.id;
      },
    );
    _users.replaceRange(userIndex, userIndex + 1, [user]);
    emit(UserSuccess(users: _users));
    print(' user update');
  }
}
