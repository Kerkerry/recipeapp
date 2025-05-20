import 'dart:convert';

import 'package:recipeapp/core/constants/recipe_constants.dart';
import 'package:recipeapp/core/errors/api_exception.dart';
import 'package:recipeapp/core/helpers/internet_connection_helper.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:recipeapp/src/data/datasources/local_datasource/home_db_service.dart';
import 'package:recipeapp/src/data/datasources/remote_datasource/datasource/recipe_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:recipeapp/src/data/models/recipe_model.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
class RecipeRemoteDatasourceImplementation implements RecipeRemoteDatasource{
  final http.Client _client;
  const RecipeRemoteDatasourceImplementation({required http.Client client}):_client=client;

  @override
  Future<Recipe> getRecipe({required int id})async {
    try{
      final response=await _client.get(Uri.https(kBaseUrl,"$recipesEndpoint/$id"));
      if(response.statusCode !=200){
        throw(ApiException(statusCode: response.statusCode,message: response.body));
      }
      return RecipeModel.fromMap(jsonDecode(response.body));
    } catch(e){
      throw(ApiException(statusCode: 505,message: e.toString()));
    }
  }

  @override
  Future<List<Recipe>> getRecipes() async{
    final bool isConnected=await sl<InternetConnectionHelper>().checkConnection();
    final bool isDataAvailable=await sl<HomeDbService>().isDataAvailable();
    try{
      if(isConnected){
        final response=await _client.get(Uri.https(kBaseUrl,recipesEndpoint,limit));
        if(response.statusCode!=200){
          throw(ApiException(statusCode: response.statusCode,message: response.body));
        }
        sl<HomeDbService>().insertRecipesToLocalDatabase(jsonDecode(response.body)['recipes']);
        final dbResult=await sl<HomeDbService>().getAll();
        return List.from(dbResult).map((recipe)=>RecipeModel.fromMap(recipe)).toList();
      }else{
        if(isDataAvailable){
          final dbResult=await sl<HomeDbService>().getAll();
          final dbJson=jsonEncode(dbResult);
          return List.from(jsonDecode(dbJson)).map((recipe)=>RecipeModel.fromMap(recipe)).toList();
        }else{
          throw(const ApiException(statusCode: 505,message: "No data in local db"));
        }
      }
    }catch(e){
      if(isDataAvailable){
        final dbResult=await sl<HomeDbService>().getAll();
        final dbJson=jsonEncode(dbResult);
        return List.from(jsonDecode(dbJson)).map((recipe)=>RecipeModel.fromMap(recipe)).toList();
      }else{
        logger.d(e);
        rethrow;
      }
    }
  }

}