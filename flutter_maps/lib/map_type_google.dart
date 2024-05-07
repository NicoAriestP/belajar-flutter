enum Type { Normal, Hybrid, Terrain, Satellite }

class mapTypeGoogle {
  late Type type;
  mapTypeGoogle({required this.type});
}

List<mapTypeGoogle> googleMapTypes = [
  mapTypeGoogle(type: Type.Normal),
  mapTypeGoogle(type: Type.Hybrid),
  mapTypeGoogle(type: Type.Terrain),
  mapTypeGoogle(type: Type.Satellite),
];
