import 'package:recipeapp/src/domain/entities/recipe.dart';

abstract class RecipeRemoteDatasource{
  const RecipeRemoteDatasource();
  Future<List<Recipe>> getRecipes();
  Future<Recipe> getRecipe({required int id});
}