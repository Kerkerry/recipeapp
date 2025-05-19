import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key, required this.recipe});
  final Recipe recipe;
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   // title:  Text(widget.recipe.name),
      //   // centerTitle: true,
      // ),
      body: SizedBox(
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
                    imageUrl: widget.recipe.image,
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
                                    Navigator.pop(context);
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
                  // margin: EdgeInsets.only(bottom: width*0.1),
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
                        Text(widget.recipe.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${widget.recipe.ingredients.length}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
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
                                  Text("${widget.recipe.cookTimeMinutes} mins",style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  const Icon(Icons.restaurant, color: Colors.orange,),
                                  const SizedBox(width: 7,),
                                  Text("${widget.recipe.caloriesPerServing} Kali",style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  const Icon(Icons.access_time, color: Colors.orange,),
                                  const SizedBox(width: 7,),
                                  Text("${widget.recipe.servings} serve",style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
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
                              itemCount: widget.recipe.ingredients.length,
                              itemBuilder: (context, index) {
                                return Text("${index+1}: ${widget.recipe.ingredients[index]}");
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
                            itemCount: widget.recipe.instructions.length,
                            itemBuilder: (context, index) {
                              return Text("${index+1}: ${widget.recipe.instructions[index]}");
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
      ),
    );
  }
}

