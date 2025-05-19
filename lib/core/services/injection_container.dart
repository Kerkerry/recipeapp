part of 'i_path.dart';

final sl=GetIt.instance;

Future init()async{
 await Hive.initFlutter();
  sl..registerFactory(()=>RecipeBloc(
      getRecipe: sl(),
      getRecipes: sl())
  )
      ..registerLazySingleton(()=>GetRecipe(recipeRepository: sl()))
      ..registerLazySingleton(()=>GetRecipes(recipeRepository: sl()))
      ..registerLazySingleton<RecipeRepository>(()=>RecipeRepositoryImplementation(recipeRemoteDatasourceImplementation: sl()))
      ..registerLazySingleton(()=>RecipeRemoteDatasourceImplementation(client: sl()))
      ..registerLazySingleton(()=>HomeDbService())
      ..registerLazySingleton(()=>const InternetConnectionHelper())
      ..registerLazySingleton(()=>http.Client());
  await sl<HomeDbService>().initHiveDatabase();


}