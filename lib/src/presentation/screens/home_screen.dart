
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipeapp/core/helpers/internet_connection_helper.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:recipeapp/core/utils/custom_alert.dart';
import 'package:recipeapp/core/utils/custom_loading_widget.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/src/presentation/recipe_providers/recipes_provider.dart';
import 'package:recipeapp/src/presentation/screens/favorite_screen.dart';
import 'package:recipeapp/src/presentation/widgets/b_n_b.dart';
import 'package:recipeapp/src/presentation/widgets/single_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 void fetchRecipes(){
   context.read<RecipeBloc>().add(const GetRecipesEvent());
 }

 @override
  void initState() {
    fetchRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider=context.watch<RecipesProvider>();
    return BlocConsumer<RecipeBloc,RecipeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              title:const Text("Recipes"),
              centerTitle: true,
            ),
            body:state is RecipeErrorState?
                       Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                state.message,
                              ),
                              const SizedBox(height: 10,),
                              IconButton(
                                  onPressed: (){
                                    context.read<RecipeBloc>().add(const GetRecipesEvent());
                                  },
                                  icon: const Icon(Icons.refresh, size: 50,)
                              )
                            ],
                          ),
                      ):state is GettingRecipesState?
                       Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomLoadingWidget.show(context),
                            const SizedBox(height: 10,),
                            const Text("Fetching recipes")
                          ],
                        ),
                      ):state is RecipesLoadedState?
                      ListView.builder(
                        itemCount: state.recipes.length,
                          itemBuilder: (context, index) {
                            final Recipe recipe=state.recipes[index];
                            return RecipeListItem(recipe: recipe,ids: state.ids,);
                          },
                      ):state is FavoriteAddedState?
                      ListView.builder(
                          itemCount: state.recipes.length,
                            itemBuilder: (context, index) {
                              final Recipe recipe=state.recipes[index];
                              return RecipeListItem(recipe: recipe,ids: state.ids!,);
                            },
                          ):state is FavoriteRemovedState?
                      ListView.builder(
                        itemCount: state.recipes.length,
                          itemBuilder: (context, index) {
                            final Recipe recipe=state.recipes[index];
                            return RecipeListItem(recipe: recipe,ids: state.ids!,);
                          },
                        ):
                      const SizedBox.shrink(),
            bottomNavigationBar:const BNB(),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const FavoriteScreen()));
              },
              child:const Icon(Icons.favorite,color: Colors.red),
            ),
          );
        },
        listener: (context, state) async{
          if(state is RecipesLoadedState){
            final int recipes=state.recipes.length;
            final bool isConnected=await sl<InternetConnectionHelper>().checkConnection();
            final String serverType=isConnected ? "Fetched $recipes recipes from remote server": "Fetched $recipes recipes from local server";
            context.mounted?CustomAlert.show(context, serverType):null;
          }
        },

    );
  }
}
