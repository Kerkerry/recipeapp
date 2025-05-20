import 'package:hive/hive.dart';
import 'package:recipeapp/core/errors/api_exception.dart';
import 'package:recipeapp/core/errors/api_failure.dart';
import 'package:recipeapp/core/helpers/hive_helper/db_keys.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
import 'package:recipeapp/src/data/datasources/local_datasource/interface_repository.dart';
import 'package:recipeapp/src/data/models/recipe_model.dart';


class HomeDbService implements InterfaceRepository{
  final String _key=DbKeys.recipeKey;
  final String _favoriteKey=DbKeys.favoriteKey;
  late final Box _recipesBox;
  late final Box _favoriteBox;
  Future initHiveDatabase()async{
    try{
        Hive.registerAdapter(RecipeModelAdapter());
        _recipesBox=await Hive.openBox(_key);
        _favoriteBox=await Hive.openBox(_favoriteKey);
        logger.d("Success on initializing database for *Recipes*");
    }catch (e){
      logger.e("Error on initializing database for *Recipes*: $e");
      throw ApiException(statusCode: 505, message: e.toString());
    }
  }

  @override
  Future getAll() async{
    try{
        if(_recipesBox.isOpen && _recipesBox.isNotEmpty){
          final response= _recipesBox.get(_key);
          logger.d("Success on fetching data from local *Recipes* database");
          return response;
        }else{
          return null;
        }
    }catch (e){
      logger.e("Error on fetching database for *Recipes*: $e");
      throw ApiException(statusCode: 505, message: e.toString());
    }
  }

  @override
  Future insertRecipesToLocalDatabase(List object) async{
    try{
      await _recipesBox.put(_key, object);
      logger.d("Success on inserting data into local *Recipes* database");
    }catch (e){
      logger.e("Error on inserting database for *Recipes*: $e");
      throw ApiException(statusCode: 505, message: e.toString());
    }
  }

  @override
  Future<bool> isDataAvailable()async {
    try{
      return _recipesBox.isNotEmpty;
    }catch (e){
      logger.e("Error checking local database *Recipes*: $e");
      throw ApiException(statusCode: 505, message: e.toString());
    }
    return false;
  }

  @override
  Future addFavorite(int id) async{
    try{
      final recipes= _favoriteBox.values.toList();
      if(recipes.contains(id)){
        removeFavorite(id);
        logger.d("Recipe already exists in favorites");
      }else{
        await _favoriteBox.add(id);
        logger.d("Success adding $id to favorite");
      }
    }catch (e){
      rethrow;
    }
  }

  @override
  Future removeFavorite(int id) async{
    try{
      int index=_favoriteBox.values.toList().indexOf(id);
      if(index!=-1){
        await _favoriteBox.deleteAt(index);
        logger.d("Success removing $id from favorite");
      }else{
        logger.d("Failed removing $id from favorite because it does not exist");
      }
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List> getFavorites()async {
    try{
      return _favoriteBox.values.toList();
    }catch (e){
      logger.d("Error: $e");
      rethrow;
    }
  }
}