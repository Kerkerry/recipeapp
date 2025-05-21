import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/core/services/i_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipeapp/src/presentation/bloc/recipe_bloc.dart';
import 'package:recipeapp/src/presentation/recipe_providers/recipes_provider.dart';
import 'package:recipeapp/src/presentation/screens/home_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(ChangeNotifierProvider(
      create:(context)=>RecipesProvider(),
      child: const RecipeApp())
  );
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RecipeBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
