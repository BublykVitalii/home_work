import 'package:flutter/foundation.dart';

import 'package:user_manager/models/car.dart';

enum Sex { male, female, other }

class User {
  final String firstName;
  final String lastName;
  final int? age;
  final Sex? sex;
  final double? height;
  final double? weight;
  final List<Car>? cars;
  final String? phone;
  final int? id;

  User({
    required this.firstName,
    required this.lastName,
    this.age,
    this.sex,
    this.height,
    this.weight,
    this.cars,
    this.phone,
    this.id,
  });

  String get fullName => '$firstName $lastName';
  void addCar(Car car) => cars?.add(car);
  void deleteCar(Car car) => cars?.remove(car);

  static String parseEnumToString(Sex sex) {
    switch (sex) {
      case Sex.female:
        return 'Female';

      case Sex.male:
        return 'Male';

      case Sex.other:
      default:
        return 'Other';
    }
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, age: $age, sex: $sex, height: $height, weight: $weight, cars: $cars, phone: $phone, id: $id,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.sex == sex &&
        other.height == height &&
        other.weight == weight &&
        listEquals(other.cars, cars) &&
        other.phone == phone &&
        other.id == id;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        sex.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        cars.hashCode ^
        phone.hashCode ^
        id.hashCode;
  }
}
