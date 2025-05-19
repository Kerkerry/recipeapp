import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:recipeapp/core/helpers/hive_helper/recipe_hive_fields.dart';

class Recipe extends HiveObject{
  @HiveField(RecipeHiveFields.id)
  final int id;
  @HiveField(RecipeHiveFields.name)
  final String name;
  @HiveField(RecipeHiveFields.ingredients)
  final List ingredients;
  @HiveField(RecipeHiveFields.instructions)
  final List instructions;
  @HiveField(RecipeHiveFields.prepTimeMinutes)
  final int prepTimeMinutes;
  @HiveField(RecipeHiveFields.cookTimeMinutes)
  final int cookTimeMinutes;
  @HiveField(RecipeHiveFields.servings)
  final int servings;
  @HiveField(RecipeHiveFields.difficulty)
  final String difficulty;
  @HiveField(RecipeHiveFields.cuisine)
  final String cuisine;
  @HiveField(RecipeHiveFields.caloriesPerServing)
  final int caloriesPerServing;
  @HiveField(RecipeHiveFields.tags)
  final List tags;
  @HiveField(RecipeHiveFields.userId)
  final int userId;
  @HiveField(RecipeHiveFields.image)
  final String image;
  @HiveField(RecipeHiveFields.rating)
  final double rating;
  @HiveField(RecipeHiveFields.reviewCount)
  final int reviewCount;
  @HiveField(RecipeHiveFields.mealType)
  final List mealType;

  Recipe({required this.id, required this.name, required this.ingredients, required this.instructions, required this.prepTimeMinutes, required this.cookTimeMinutes, required this.servings, required this.difficulty, required this.cuisine, required this.caloriesPerServing, required this.tags, required this.userId, required this.image, required this.rating, required this.reviewCount, required this.mealType});

  // @override
  // // TODO: implement props
  // List<Object?> get props => [id,name,prepTimeMinutes,cookTimeMinutes,servings,difficulty];
}
