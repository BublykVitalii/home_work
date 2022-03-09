enum Sex { male, female }

class User {
  final String firstName;
  final String lastName;
  final int? age;
  final Sex? sex;
  final double? height;
  final double? weight;
  final List<Car>? cars;
  final String? phone;

  User({
    required this.firstName,
    required this.lastName,
    this.age,
    this.sex,
    this.height,
    this.weight,
    this.cars,
    this.phone,
  });

  String get fullName => '$firstName $lastName';
  void addCar(Car car) => cars?.add(car);
  void deleteCar(Car car) => cars?.remove(car);
  // void updateUser(User user){}

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, age: $age, sex: $sex, height: $height, weight: $weight, cars: $cars, phone: $phone)';
  }
}

class Car {
  final String name;
  final String color;
  Car({
    required this.name,
    required this.color,
  });
}
