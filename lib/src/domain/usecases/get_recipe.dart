import 'package:recipeapp/core/typedefs/typedefs.dart';
import 'package:recipeapp/core/usecase/usecase.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';

import '../repository/recipe_repository.dart';

class GetRecipe extends UsecaseWithParams<Recipe,int>{
  final RecipeRepository _repo;
  GetRecipe({required RecipeRepository recipeRepository}):_repo=recipeRepository;

  @override
  ResultFuture<Recipe> call(int params) async=>await _repo.getRecipe(id: params);
}