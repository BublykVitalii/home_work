enum Sex { male, female }

class User {
  final String? firstName;
  final String? lastName;
  final int? age;
  final Sex? sex;
  final double? height;
  final double? weight;
  final List<Car> cars;
  final int? phone;

  User({
    required this.firstName,
    required this.lastName,
    this.age,
    this.sex,
    this.height,
    this.weight,
    required this.cars,
    this.phone,
  });

  String get fullName => '$firstName $lastName';
  void addCar(Car car) => cars.add(car);
  void deleteCar(Car car) => cars.remove(car);
  // void updateUser(User user){}

}

class Car {
  final String name;
  final String color;
  Car({
    required this.name,
    required this.color,
  });
}
