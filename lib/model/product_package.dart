class BeerUnit {
  String beerUnitID;
  int numberUnit;

  BeerUnit({required this.beerUnitID, required this.numberUnit});
}

class ProductPackage {
  String deviceID;
  String beerID;
  List<BeerUnit> beerUnits;

  ProductPackage(
      {required this.deviceID, required this.beerID, required this.beerUnits});
}
