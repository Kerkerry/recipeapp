
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:recipeapp/src/data/datasources/local_datasource/home_db_service.dart';
import 'package:recipeapp/src/data/models/recipe_model.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';

class RecipesProvider extends ChangeNotifier{
  final List<Recipe> _favRecipes=[];
   List _favorites=[];

    bool _favoriteAdded=false;

   List<Recipe> get favRecipes=>_favRecipes;
   List get favorites=>_favorites;
   bool get favoriteAdded=>_favoriteAdded;

  Future getFavRecipes()async{
    _favorites=await sl<HomeDbService>().getFavorites();
    final List recipes=await sl<HomeDbService>().getAll();
    for(final recipe in recipes){
      if(_favorites.contains(recipe['id'])){
        _favRecipes.add(RecipeModel.fromMap(recipe));
      }
    }
    notifyListeners();
  }

  void addOrRemoveFavorite({required int id})async{
    if(_favoriteAdded){
      logger.d(_favorites);
      await sl<HomeDbService>().removeFavorite(id);
      getFavRecipes();
    }else{
        logger.d(_favorites);
        await sl<HomeDbService>().addFavorite(id);
        getFavRecipes();
    }
    notifyListeners();
  }
}