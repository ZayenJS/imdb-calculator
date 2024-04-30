class Converter {
  static double kgToLbs(double kg) {
    return double.parse((kg * 2.20462).toStringAsFixed(4));
  }

  static double lbsToKg(double lbs) {
    return double.parse((lbs / 2.20462).toStringAsFixed(4));
  }
}
