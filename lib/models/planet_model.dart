class PlanetModel {
  String? planetName,
      subtitle,
      image,
      velocity,
      distance,
      orbitalPeriod,
      gravity;

  PlanetModel(
      {required this.planetName,
      required this.subtitle,
      required this.image,
      required this.velocity,
      required this.distance,
      required this.orbitalPeriod,
      required this.gravity});

  factory PlanetModel.fromJson(Map json) {
    return PlanetModel(
        planetName: json['name'],
        subtitle: json['subtitle'],
        image: json['image'],
        velocity: json['velocity'],
        distance: json['distance'],
        orbitalPeriod: json['orbitalPeriod'],
        gravity: json['gravity']);
  }
}
