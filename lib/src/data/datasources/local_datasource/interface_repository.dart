

abstract class InterfaceRepository{
  const InterfaceRepository();

  Future getAll();
  Future insertRecipesToLocalDatabase(List object);
  Future addFavorite(int id);
  Future<List> getFavorites();
  Future removeFavorite(int id);
  Future<bool> isDataAvailable();
}