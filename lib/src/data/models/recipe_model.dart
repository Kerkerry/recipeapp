import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:recipeapp/core/helpers/hive_helper/recipe_hive_type.dart';
import 'package:recipeapp/core/typedefs/typedefs.dart';
import 'package:recipeapp/src/domain/entities/recipe.dart';
part 'recipe_model.g.dart';

@HiveType(typeId: RecipeHiveType.recipeModel)
class RecipeModel extends Recipe{
   RecipeModel({required super.id, required super.name, required super.ingredients, required super.instructions, required super.prepTimeMinutes, required super.cookTimeMinutes, required super.servings, required super.difficulty, required super.cuisine, required super.caloriesPerServing, required super.tags, required super.userId, required super.image, required super.rating, required super.reviewCount, required super.mealType});

  RecipeModel.fromMap(DataMap map):this(
      id:map['id'],
      name:map['name'],
      ingredients:map['ingredients'],
      instructions:map['instructions'],
      prepTimeMinutes:map['prepTimeMinutes'],
      cookTimeMinutes:map['cookTimeMinutes'],
      servings:map['servings'],
      difficulty:map['difficulty'],
      cuisine:map['cuisine'],
      caloriesPerServing:map['caloriesPerServing'],
      tags:map['tags'],
      userId:map['userId'],
      image:map['image'],
      rating:map['rating'].toDouble(),
      reviewCount:map['reviewCount'],
      mealType:map['mealType']
  );

  RecipeModel fromJson(String source)=>RecipeModel.fromMap(jsonDecode(source));

  RecipeModel copyWith(
  {
    String? name,
    List? ingredients,
    List? instructions,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    int? servings,
    String? difficulty,
    String? cuisine,
    int ? caloriesPerServing,
    List? tags,
    int? userId,
    String? image,
    double? rating,
    int? reviewCount,
    List? mealType
}){
    return RecipeModel(
      id:id,
      name:name??this.name,
      ingredients:ingredients??this.ingredients,
      instructions: instructions??this.instructions,
      prepTimeMinutes: prepTimeMinutes??this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes??this.cookTimeMinutes,
      servings: servings??this.servings,
      difficulty: difficulty??this.difficulty,
      cuisine: cuisine??this.cuisine,
      caloriesPerServing: caloriesPerServing??this.caloriesPerServing,
      tags: tags??this.tags,
      userId: userId??this.userId,
      image: image??this.image,
      rating: rating??this.rating,
      reviewCount: reviewCount??this.reviewCount,
      mealType: mealType??this.mealType
    );
  }

  DataMap toMap()=>{
    'id':id,
    'name':name,
    'ingredients':ingredients,
    'instructions':instructions,
    'prepTimeMinutes':prepTimeMinutes,
    'cookTimeMinutes':cookTimeMinutes,
    'servings':servings,
    'difficulty':difficulty,
    'cuisine':cuisine,
    'caloriesPerServing':caloriesPerServing,
    'tags':tags,
    'userId':userId,
    'image':image,
    'rating':rating,
    'reviewCount':reviewCount,
    'mealType':mealType
  };

  String toJson()=>jsonEncode(toMap());

  RecipeModel.empty():this(
     id: 0, name: "Item 1", ingredients: [], instructions: [], prepTimeMinutes: 0, cookTimeMinutes: 0, servings: 0, difficulty: 'Not defined', cuisine: 'Not known', caloriesPerServing: 0, tags: [], userId: 0, image: 'https://plus.unsplash.com/premium_photo-1673108852141-e8c3c22a4a22?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D', rating: 0, reviewCount: 0, mealType: []);

}