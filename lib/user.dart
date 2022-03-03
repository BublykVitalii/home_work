enum Sex { male, female }

class User {
  final String firstName;
  final String lastName;
  final int age;
  final Sex sex;
  final int height;
  final int weight;
  final List<Car> cars;
  final int phone;

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.sex,
    required this.height,
    required this.weight,
    required this.cars,
    required this.phone,
  });

  String get fullName => '$firstName $lastName';
  void addCar(Car car) => cars.add(car);
  void deleteCar(Car car) => cars.remove(car);
}

class Car {
  final String name;
  final String color;
  Car({
    required this.name,
    required this.color,
  });
}
