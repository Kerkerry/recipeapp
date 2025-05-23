
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:recipeapp/src/data/datasources/local_datasource/home_db_service.dart';
import 'package:recipeapp/src/data/models/recipe_model.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';

class RecipesProvider extends ChangeNotifier{
  final List<Recipe> _favRecipes=[];
   List _favorites=[];

    final bool _favoriteAdded=false;

   UnmodifiableListView<Recipe> get favRecipes=>UnmodifiableListView(_favRecipes);
   UnmodifiableListView get favorites=>UnmodifiableListView(_favorites);
   bool get favoriteAdded=>_favoriteAdded;

  Future getFavRecipes()async{
    _favorites=await sl<HomeDbService>().getFavorites();
    final List recipes=await sl<HomeDbService>().getAll();
    for(final recipe in recipes){
      if(_favorites.contains(recipe['id'])){
          final jsonRecipe=jsonEncode(recipe);
        _favRecipes.add(RecipeModel.fromMap(jsonDecode(jsonRecipe)));
        notifyListeners();
      }
    }
  }

  void addFavorite({required int id})async{
    await sl<HomeDbService>().addFavorite(id);
    notifyListeners();
  }

  void removeFavorite({required int id})async{
    await sl<HomeDbService>().removeFavorite(id);
    notifyListeners();
  }

  void addOrRemoveFavorite({required int id})async{
    if(_favoriteAdded){
      logger.d(_favorites);
      await sl<HomeDbService>().removeFavorite(id);
      notifyListeners();
    }else{
        logger.d(_favorites);
        await sl<HomeDbService>().addFavorite(id);
        notifyListeners();
    }
  }
}