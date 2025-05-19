import 'package:recipeapp/core/typedefs/typedefs.dart';
import 'package:recipeapp/core/usecase/usecase.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/domain/repository/recipe_repository.dart';

class GetRecipes extends UsecaseWithoutParams<List<Recipe>>{
  final RecipeRepository _repo;
   GetRecipes({required RecipeRepository recipeRepository}):_repo=recipeRepository;

  @override
  ResultFuture<List<Recipe>> call() async=>await _repo.getRecipes();
}