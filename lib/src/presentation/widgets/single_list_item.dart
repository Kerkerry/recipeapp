import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:recipeapp/core/utils/custom_image_viewer.dart';
import 'package:recipeapp/src/data/datasources/local_datasource/home_db_service.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/src/presentation/screens/recipe_detail_screen.dart';

class RecipeListItem extends StatefulWidget {
  final Recipe recipe;
  const RecipeListItem({super.key, required this.recipe});

  @override
  State<RecipeListItem> createState() => _RecipeListItemState();
}

class _RecipeListItemState extends State<RecipeListItem> {
  final List _ids=[];
  void getFavsIds()async{
    final ids=await sl<HomeDbService>().getFavorites();
    _ids.addAll(ids);
  }

  @override
  void initState() {
    getFavsIds();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);
    return  BlocConsumer<RecipeBloc,RecipeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return InkWell(
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  RecipeDetailScreen(recipe: widget.recipe))),
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
                        context: context, url: widget.recipe.image),
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
                                widget.recipe.name,
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
                                      "${widget.recipe
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
                                      "${widget.recipe.prepTimeMinutes} mins",
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
                                      "${widget.recipe.cookTimeMinutes} mins",
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
                                  widget.recipe.cuisine,
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
                                  onPressed: () {
                                    if (_ids.contains(widget.recipe.id)) {
                                      sl<HomeDbService>().removeFavorite(widget.recipe.id);
                                    } else {
                                      sl<HomeDbService>().addFavorite(
                                          widget.recipe.id);
                                    }
                                  },
                                  icon: state is FavoriteRecipesLoadedState?
                                  Icon(
                                      _ids.contains(widget.recipe.id) ? Icons
                                  .favorite : Icons.favorite_border,
                                      color: Colors.red,):
                                  state is FavoriteAddedState ?
                                  Icon(
                                      _ids.contains(widget.recipe.id) ? Icons
                                          .favorite : Icons.favorite_border,
                                          color: Colors.red,):
                                  state is FavoriteRemovedState?
                                  Icon(
                                    _ids.contains(widget.recipe.id) ? Icons
                                        .favorite : Icons.favorite_border,
                                      color: Colors.red,):
                                  const Icon(Icons.favorite_border, size: 35, color: Colors.red,)

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
    );
  }
}
