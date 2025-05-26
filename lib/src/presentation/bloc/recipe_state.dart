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
  final List ids;

  const RecipesLoadedState({required this.recipes,required this.ids});

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
  final List recipes;
  final List? ids;
  const FavoriteRecipesLoadedState({required this.recipes,this.ids});
}


class AddingFavoriteState extends RecipeState{
  const AddingFavoriteState();
}
class FavoriteAddedState extends RecipeState{
  final List<Recipe> recipes;
  final List? ids;
  const FavoriteAddedState({required this.recipes,this.ids});
}

class RemovingFavoriteState extends RecipeState{
  const RemovingFavoriteState();
}

class FavoriteRemovedState extends RecipeState{
  final List<Recipe> recipes;
  final List? ids;
  const FavoriteRemovedState({required this.recipes,this.ids});
}

class RecipeErrorState extends RecipeState{
  final String message;
  const RecipeErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

