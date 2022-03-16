class Car {
  final String owner;
  final String name;
  final String color;
  Car({
    required this.owner,
    required this.name,
    required this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Car &&
        other.owner == owner &&
        other.name == name &&
        other.color == color;
  }

  @override
  int get hashCode => owner.hashCode ^ name.hashCode ^ color.hashCode;
}
