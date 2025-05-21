

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/core/utils/custom_loading_widget.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/src/presentation/recipe_providers/recipes_provider.dart';
import 'package:recipeapp/src/presentation/widgets/single_list_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void fetchFavRecipes(){
    context.read<RecipeBloc>().add(const GetRecipesFavoriteEvent());
  }

  @override
  void initState() {
    fetchFavRecipes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final recipeProvider=context.watch<RecipesProvider>();
    final favRecipes=recipeProvider.favRecipes;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite recipes"),
      ),
      body: favRecipes.isEmpty?
          const Center(child: Text("There are no favorites recipes"),):Consumer<RecipesProvider>(
        builder: (context, value, child){
          return ListView.builder(
            itemCount: favRecipes.length,
            itemBuilder: (context, index) {
              final Recipe recipe=favRecipes[index];
              return RecipeListItem(recipe: recipe, isAddedToFavorites: recipeProvider.favorites.contains(recipe.id));
            },
          );
        },
      )
    );
  }
}
