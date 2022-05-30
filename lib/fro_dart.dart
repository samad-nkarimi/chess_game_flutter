void main(List<String> args) {
  // MapOwner mapOwner = MapOwner();
  MapOwner().map[1] = "salam";
  print(MapOwner().map);
}

class MapOwner {
  static final MapOwner _singleton = MapOwner._internal();

  factory MapOwner() {
    return _singleton;
  }

  MapOwner._internal();
  final Map<int, String> map = {};
}
