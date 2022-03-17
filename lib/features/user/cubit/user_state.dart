part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User>? users;
  final List<Car>? cars;
  UserSuccess({
    this.users,
    this.cars,
  });
}

class UserError extends UserState {}
