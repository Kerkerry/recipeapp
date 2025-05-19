
import 'package:recipeapp/src/domain/entities/recipe.dart';

abstract class InterfaceRepository{
  const InterfaceRepository();

  Future getAll();
  Future insertRecipesToLocalDatabase(List object);
  Future<bool> isDataAvailable();
}