class PlanetModel {
  String? planetName,
      subtitle,
      image,
      velocity,
      distance,
      orbitalPeriod,
      gravity,
      lengthOfDay,
      surfaceArea;

  PlanetModel(
      {required this.planetName,
      required this.subtitle,
      required this.image,
      required this.velocity,
      required this.distance,
      required this.orbitalPeriod,
      required this.gravity,
      required this.lengthOfDay,
      required this.surfaceArea});

  factory PlanetModel.fromJson(Map json) {
    return PlanetModel(
        planetName: json['name'],
        subtitle: json['subtitle'],
        image: json['image'],
        velocity: json['velocity'],
        distance: json['distance'],
        orbitalPeriod: json['orbital_period'],
        gravity: json['gravity'],
        lengthOfDay: json['length_of_day'],
        surfaceArea: json['surface_area']);
  }
}
