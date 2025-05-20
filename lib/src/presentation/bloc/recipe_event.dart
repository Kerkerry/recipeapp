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

class AddFavoriteEvent extends RecipeEvent{
  final int id;
  const AddFavoriteEvent(this.id);
}

class RemoveFavoriteEvent extends RecipeEvent{
  final int id;
  const RemoveFavoriteEvent(this.id);
}

class GetFavoriteEvent extends RecipeEvent{
  const GetFavoriteEvent();
}

