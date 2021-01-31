class ConvertString {
  int getNumber(String feature, int endPoint) {
    return int.parse(RegExp(r'(\d+)')
        .allMatches(feature.toString())
        .map((e) => e.group(0))
        .join(' ')
        .toString()
        .substring(0, endPoint));
  }

  double getScreenSize(int index, String feature, int endPoint) {
    return double.parse(RegExp(r'(\d+)')
        .allMatches(feature.toString())
        .map((e) => e.group(0))
        .join('.')
        .toString()
        .substring(0, endPoint));
  }

  // int getCamera(int index) {
  //   return getNumber(index, 'primary_camera', 2);
  // }

  // int getRam(int index) {
  //   return getNumber(index, 'ram', 1);
  // }

  // int getStorage(int index) {
  //   return getNumber(index, 'storage', 3);
  // }

  // int getBattery(int index) {
  //   return getNumber(index, 'battery', 4);
  // }

  // int getWaight(int index) {
  //   return getNumber(index, 'weight', 4);
  // }
}
