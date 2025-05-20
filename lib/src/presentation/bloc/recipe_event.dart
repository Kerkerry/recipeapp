part of 'recipe_bloc.dart';

class RecipeEvent extends Equatable{
  const RecipeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetRecipesEvent extends RecipeEvent{
  const GetRecipesEvent();
}

class GetRecipeEvent extends RecipeEvent{
  final int id;
  const GetRecipeEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class AddRecipeFavoriteEvent extends RecipeEvent{
  final int id;
  const AddRecipeFavoriteEvent(this.id);
}

class RemoveRecipeFavoriteEvent extends RecipeEvent{
  final int id;
  const RemoveRecipeFavoriteEvent(this.id);
}

class GetRecipesFavoriteEvent extends RecipeEvent{
  const GetRecipesFavoriteEvent();
}

