part of 'recipe_bloc.dart';
class RecipeState extends Equatable{
  const RecipeState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RecipeInitialState extends RecipeState{
  const RecipeInitialState();
}

class GettingRecipesState extends RecipeState{
  const GettingRecipesState();
}

class RecipesLoadedState extends RecipeState{
  final List<Recipe> recipes;

  const RecipesLoadedState({required this.recipes});

  @override
  // TODO: implement props
  List<Object?> get props => recipes.map((recipe)=>recipe.id).toList();
}

class GettingRecipeState extends RecipeState{
  const GettingRecipeState();
}

class RecipeLoadedState extends RecipeState{
  final Recipe recipe;

  const RecipeLoadedState({required this.recipe});

  @override
  List<Object?> get props => [recipe.id];
}

class GettingFavoriteRecipesState extends RecipeState{
  const GettingFavoriteRecipesState();
}

class FavoriteRecipesLoadedState extends RecipeState{
  final List favorites;
  final List<Recipe> recipes;
  const FavoriteRecipesLoadedState({required this.favorites, required this.recipes});
}

class AddingFavoriteState extends RecipeState{
  final int id;
  const AddingFavoriteState({required this.id});
}

class FavoriteAddedState extends RecipeState{
  const FavoriteAddedState();
}

class RemovingFavoriteState extends RecipeState{
  final int id;
  const RemovingFavoriteState({required this.id});
}

class FavoriteRemovedState extends RecipeState{
  const FavoriteRemovedState();
}

class RecipeErrorState extends RecipeState{
  final String message;
  const RecipeErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

