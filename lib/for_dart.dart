// void main(List<String> args) {
//   // MapOwner mapOwner = MapOwner();
//   MapOwner().map[1] = "salam";
//   print(MapOwner().map);
// }

// class MapOwner {
//   static final MapOwner _singleton = MapOwner._internal();

//   factory MapOwner() {
//     return _singleton;
//   }

//   MapOwner._internal();
//   final Map<int, String> map = {};
// }

//************************************* */
// void main(List<String> args) {
//   List<String> getName() {
//     return ["samad", "n"];
//   }

//   var p = Person(getName);
//   print(p.list);
// }

// class Human {}

// class Person extends Human {
//   List<String> list;
//   Function function;
//   Person(this.function)
//       : list = function(),
//         super();
// }

void main(List<String> args) {
  var d = DateTime.now();
  print(d.toString());
  var dd = DateTime.parse(d.toString());
  print(dd);
}
