class Mpin {
  String? mpin;

  Mpin({
    this.mpin,
  });

  Mpin.fromMap(
      Map map) // This Function helps to convert our Map into our Mpin Object
      : mpin = map["mpin"];

  Map toMap() {
    // This Function helps to convert our Object into a Map.
    return {
      "mpin": mpin,
    };
  }
}
