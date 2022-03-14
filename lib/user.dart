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
  // void updateUser(User user){}

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
}

class Car {
  final String owner;
  final String name;
  final String color;
  Car({
    required this.owner,
    required this.name,
    required this.color,
  });
}
