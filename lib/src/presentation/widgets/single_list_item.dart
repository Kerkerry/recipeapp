import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/core/utils/custom_image_viewer.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/src/presentation/recipe_providers/recipes_provider.dart';
import 'package:recipeapp/src/presentation/screens/recipe_detail_screen.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final List ids;
  const RecipeListItem({super.key, required this.recipe, required this.ids});

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);
    final recipeProvider=context.watch<RecipesProvider>();
        return InkWell(
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  RecipeDetailScreen(recipe: recipe))),
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: height * 0.01
            ),
            height: height * 0.263,
            decoration: BoxDecoration(
                color: theme.dialogBackgroundColor,
                borderRadius: BorderRadius.circular(height * 0.02)
            ),
            child: Material(
              borderRadius: BorderRadius.circular(height * 0.02),
              elevation: 1,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: width * 0.35,
                    decoration: BoxDecoration(
                        color: theme.dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: CustomImageViewer.show(
                        context: context, url: recipe.image),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Calories per Serving Spoon ",
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    Text(
                                      "${recipe
                                          .caloriesPerServing} kcal",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Preparation Time ",
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    Text(
                                      "${recipe.prepTimeMinutes} mins",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Cook Time ",
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    Text(
                                      "${recipe.cookTimeMinutes} mins",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width * 0.06,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Text(
                                      "Cuisine",
                                      style: theme.textTheme.labelLarge!
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  recipe.cuisine,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    if(ids.contains(recipe.id)){
                                      context.read<RecipeBloc>().add(RemoveRecipeFavoriteEvent(recipe.id));
                                    }else{
                                      context.read<RecipeBloc>().add(AddRecipeFavoriteEvent(recipe.id));
                                    }
                                  },
                                icon:  Icon(ids.contains(recipe.id)?Icons.favorite:Icons.favorite_border,color: Colors.red,)
                              )
                            ],
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        );
  }
}
