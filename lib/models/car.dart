class Car {
  final String owner;
  final String name;
  final String color;
  final int? ownerId; // car id?
  Car({
    required this.owner,
    required this.name,
    required this.color,
    this.ownerId,
  });

  @override
  String toString() {
    return 'Car(owner: $owner, name: $name, color: $color, ownerId: $ownerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Car &&
        other.owner == owner &&
        other.name == name &&
        other.color == color &&
        other.ownerId == ownerId;
  }

  @override
  int get hashCode {
    return owner.hashCode ^ name.hashCode ^ color.hashCode ^ ownerId.hashCode;
  }
}
