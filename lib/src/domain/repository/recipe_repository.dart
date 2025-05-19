import 'package:recipeapp/core/typedefs/typedefs.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';

abstract class RecipeRepository{
  const RecipeRepository();
  ResultFuture<List<Recipe>> getRecipes();
  ResultFuture<Recipe> getRecipe({required int id});
}