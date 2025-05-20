import 'package:dartz/dartz.dart';
import 'package:recipeapp/core/errors/api_exception.dart';
import 'package:recipeapp/core/errors/api_failure.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
import 'package:recipeapp/core/typedefs/typedefs.dart';
import 'package:recipeapp/src/data/datasources/remote_datasource/datasource_implementation/recipe_remote_datasource_implementation.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/domain/repository/recipe_repository.dart';

class RecipeRepositoryImplementation implements RecipeRepository{
  final RecipeRemoteDatasourceImplementation _dtsrc;
  const RecipeRepositoryImplementation({required RecipeRemoteDatasourceImplementation recipeRemoteDatasourceImplementation}):_dtsrc=recipeRemoteDatasourceImplementation;

  @override
  ResultFuture<Recipe> getRecipe({required int id}) async{
    try{
      final result=await _dtsrc.getRecipe(id: id);
      return Right(result);
    }on ApiException catch (e){
      logger.e(e);
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Recipe>> getRecipes() async{
    try{
      final result=await _dtsrc.getRecipes();
      return Right(result);
    }on ApiException catch(e){
      logger.d(e);
      return Left(ApiFailure.fromException(e));
    }
  }

}