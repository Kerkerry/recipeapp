

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipeapp/core/helpers/logger_helper.dart';
import 'package:recipeapp/core/utils/custom_loading_widget.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite recipes"),
      ),
      body: BlocConsumer<RecipeBloc,RecipeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is RecipeErrorState){
            return Center(
              child: Text(state.message),
            );
          }else if(state is GettingFavoriteRecipesState){
            return Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomLoadingWidget.show(context),
                  const SizedBox(height: 10,),
                  const Text("Fetching recipes")
              ],
            );
          }else if(state is FavoriteRecipesLoadedState){
           return  ListView.builder(
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                final Recipe recipe=state.recipes[index];
                return RecipeListItem(recipe: recipe);
              },
            );
          }else{
            return  Container();
          }
        },
      ),
    );
  }
}
