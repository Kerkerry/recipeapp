import 'dart:async';

import 'package:equatable/equatable.dart';
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
}
