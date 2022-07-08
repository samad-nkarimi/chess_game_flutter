class ServiceLocator {
  String username = '';
  static final ServiceLocator _singleton = ServiceLocator._internal();
  factory ServiceLocator() {
    return _singleton;
  }
  ServiceLocator._internal();

  void setUsername(String username) {
    this.username = username;
  }
}
