import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:recipeapp/src/data/datasources/local_datasource/home_db_service.dart';
import 'package:recipeapp/src/data/models/recipe_model.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:bloc/bloc.dart';
import 'package:recipeapp/src/domain/usecases/get_recipe.dart';
import 'package:recipeapp/src/domain/usecases/get_recipes.dart';
part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent,RecipeState>{
 final GetRecipe _getRecipe;
 final GetRecipes _getRecipes;
     RecipeBloc({
       required GetRecipe getRecipe,
       required GetRecipes getRecipes
    }):
           _getRecipes=getRecipes,
           _getRecipe=getRecipe,
           super(const RecipeInitialState())
     {
       on<GetRecipeEvent>(_getRecipeHandler);
       on<GetRecipesEvent>(_getRecipesHandler);
       on<AddRecipeFavoriteEvent>(_addRecipeFavoriteHandler);
       on<GetRecipesFavoriteEvent>(_getRecipesFavoriteHandler);
       on<RemoveRecipeFavoriteEvent>(_removeRecipeFavoriteHandler);
     }

  FutureOr<void> _getRecipeHandler(GetRecipeEvent event, Emitter<RecipeState> emit)async {
       emit(const GettingRecipeState());
       final result=await _getRecipe(event.id);
       result.fold(
               (f)=>emit(RecipeErrorState(message: f.errorMessage)),
               (recipe)=>emit(RecipeLoadedState(recipe: recipe))
       );
  }

  FutureOr<void> _getRecipesHandler(GetRecipesEvent event, Emitter<RecipeState> emit)async {
       emit(const GettingRecipesState());
       final result=await _getRecipes();
       result.fold(
               (f)=>emit(RecipeErrorState(message: f.errorMessage)),
           (recipes)=>emit(RecipesLoadedState(recipes: recipes))
       );
  }

  FutureOr<void> _addRecipeFavoriteHandler(AddRecipeFavoriteEvent event, Emitter<RecipeState> emit) async{
       try{
         emit(const AddingFavoriteState());
         await sl<HomeDbService>().addFavorite(event.id);
         emit(const FavoriteAddedState());
       }catch(e){
         emit(RecipeErrorState(message: e.toString()));
       }
  }

  FutureOr<void> _getRecipesFavoriteHandler(GetRecipesFavoriteEvent event, Emitter<RecipeState> emit)async {
    try{
      emit(const GettingFavoriteRecipesState());
      final  favs=await sl<HomeDbService>().getFavorites();
      final List recipes=await sl<HomeDbService>().getAll();
      final List<Recipe> favRecipes=[];
      for(final recipe in recipes){
        if(favs.contains(recipe['id'])){
          favRecipes.add(RecipeModel.fromMap(recipe));
        }
      }
      emit(FavoriteRecipesLoadedState(recipes: favRecipes));
    }catch(e){
      emit(RecipeErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _removeRecipeFavoriteHandler(RemoveRecipeFavoriteEvent event, Emitter<RecipeState> emit) async{
       try{
         emit(const RemovingFavoriteState());
         await sl<HomeDbService>().removeFavorite(event.id);
         emit(const FavoriteRemovedState());
       }catch(e){
         emit(RecipeErrorState(message: e.toString()));
       }
  }
}
