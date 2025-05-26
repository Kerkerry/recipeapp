import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/core/utils/custom_loading_widget.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key, required this.id});
  final int id;
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  void fetchRecipe(){
    context.read<RecipeBloc>().add(GetRecipeEvent(id: widget.id));
  }

  @override
  void initState() {
    fetchRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: BlocBuilder<RecipeBloc,RecipeState>(
        builder: (context,state) {
            if(state is RecipeErrorState){
               return Center(child: Text(state.message),);
            }
           if(state is GettingRecipeState){
             return CustomLoadingWidget.show(context);
           }
           if(state is RecipeLoadedState){
             final recipe=state.recipe;
             return SizedBox(
               height: height,
               width: width,
               child:Stack(
                 children: [
                   Stack(
                       children: [
                         Container(
                             height: height*0.55,
                             width: width,
                             decoration: BoxDecoration(
                               color: Colors.grey,
                               borderRadius: BorderRadius.circular(width*0.06),
                             ),
                             child:CachedNetworkImage(
                               imageUrl: recipe.image,
                               fit: BoxFit.cover,
                               imageBuilder: (context, imageProvider) =>Container(
                                 decoration: BoxDecoration(
                                     color: Colors.transparent,
                                     borderRadius: BorderRadius.circular(12),
                                     image: DecorationImage(image: imageProvider,fit:BoxFit.cover)
                                 ),
                               ),
                               placeholder: (context,url)=>Container(),
                               errorWidget: (context,url,error)=>Container(
                                 width: double.infinity,
                                 decoration: BoxDecoration(
                                   color: Theme.of(context).dialogBackgroundColor,
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                                 child:const Center(
                                   child: Icon(
                                     Icons.image,
                                     size: 40,
                                   ),
                                 ) ,
                               ),
                             )
                         ),
                         Positioned(
                             child: Container(
                               margin: EdgeInsets.only(top: width*0.1,left:width*0.02,right: width*0.02),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     decoration:  BoxDecoration(
                                         color: Colors.grey,
                                         borderRadius: BorderRadius.circular(width*0.05)
                                     ),
                                     child: IconButton(
                                         onPressed: (){
                                           context.go('/');
                                         },
                                         icon: const Icon(Icons.arrow_back_ios_new,  color: Colors.white,)
                                     ),
                                   ),
                                   IconButton(
                                       onPressed: (){},
                                       icon:const Icon(Icons.favorite_border, color: Colors.red,size: 35,)
                                   )
                                 ],
                               ),
                             )
                         ),
                       ]
                   ),
                   Positioned(
                       top: height*0.5,
                       left: width*0.1,
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: width*0.03),
                         height: height*0.5,
                         width: width*0.8,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(width*0.03)
                         ),
                         child: SingleChildScrollView(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text(recipe.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),),
                               const SizedBox(height: 6,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("${recipe.ingredients.length}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                                   const SizedBox(width: 10,),
                                   const Text("Ingredients",style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                                 ],
                               ),
                               SizedBox(height: width*0.05,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   SizedBox(
                                     child: Row(
                                       children: [
                                         const Icon(Icons.access_time, color: Colors.orange,),
                                         const SizedBox(width: 7,),
                                         Text("${recipe.cookTimeMinutes} mins",style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                                       ],
                                     ),
                                   ),
                                   SizedBox(
                                     child: Row(
                                       children: [
                                         const Icon(Icons.restaurant, color: Colors.orange,),
                                         const SizedBox(width: 7,),
                                         Text("${recipe.caloriesPerServing} Kali",style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                                       ],
                                     ),
                                   ),
                                   SizedBox(
                                     child: Row(
                                       children: [
                                         const Icon(Icons.access_time, color: Colors.orange,),
                                         const SizedBox(width: 7,),
                                         Text("${recipe.servings} serve",style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                               SizedBox(height: width*0.05,),
                               const Row(
                                 children: [
                                   Text("Ingredients", style:  TextStyle(fontSize: 26, fontWeight: FontWeight.w700),),
                                 ],
                               ),
                               SizedBox(
                                 height:height*0.2,
                                 child: ListView.builder(
                                   itemCount: recipe.ingredients.length,
                                   itemBuilder: (context, index) {
                                     return Text("${index+1}: ${recipe.ingredients[index]}");
                                   },
                                 ),
                               ),
                               SizedBox(height: width*0.05,),
                               const Row(
                                 children: [
                                   Text("Instructions", style:  TextStyle(fontSize: 26, fontWeight: FontWeight.w700),),
                                 ],
                               ),
                               SizedBox(
                                 height:height*0.2,
                                 child: ListView.builder(
                                   itemCount: recipe.instructions.length,
                                   itemBuilder: (context, index) {
                                     return Text("${index+1}: ${recipe.instructions[index]}");
                                   },
                                 ),
                               ),
                             ],
                           ),
                         ),
                       )
                   )
                 ],
               ) ,
             );
           }
           return const SizedBox.shrink();
        }
      ),
    );
  }
}

