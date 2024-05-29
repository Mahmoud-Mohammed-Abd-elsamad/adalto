import 'package:adalato_app/screens/inSide_app/Explor/exercises/exercise_details_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/exercises/exercises_filter_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/exercises/exercises_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/explore_screen.dart';
import 'package:adalato_app/screens/inSide_app/Explor/programs/program_details_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/programs/programs_filter_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/programs/programs_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/shop/shop_filter_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/shop/shop_item_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/shop/shop_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/workouts/workout_details.dart';
import 'package:adalato_app/screens/inSide_app/Explor/workouts/workouts_filter_page.dart';
import 'package:adalato_app/screens/inSide_app/Explor/workouts/workouts_page.dart';
import 'package:adalato_app/screens/inSide_app/Profile/profile_page.dart';
import 'package:adalato_app/screens/inSide_app/home/home_screen.dart';
import 'package:adalato_app/screens/inSide_app/home/tips/tips_screen.dart';
import 'package:adalato_app/screens/inSide_app/home/user_exercises/my_exercise.dart';
import 'package:adalato_app/screens/inSide_app/home/user_exercises/my_exercises.dart';
import 'package:adalato_app/screens/inSide_app/home/user_programs/my_prograsms.dart';
import 'package:adalato_app/screens/inSide_app/home/user_workouts/my_workouts.dart';
import 'package:adalato_app/screens/login/login_screen.dart';
import 'package:adalato_app/screens/main_screen.dart';
import 'package:adalato_app/screens/register/gender_screen.dart';
import 'package:adalato_app/screens/register/goals_screen.dart';
import 'package:adalato_app/screens/register/height_screen.dart';
import 'package:adalato_app/screens/register/level_screen.dart';
import 'package:adalato_app/screens/register/register_screen.dart';
import 'package:adalato_app/screens/register/weight_screen.dart';
import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';



class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.start:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case AppRoutes.gender:
        return MaterialPageRoute(builder: (_) => GenderPage());
      case AppRoutes.height:
        return MaterialPageRoute(builder: (_) => HeightPage());
      case AppRoutes.weight:
        return MaterialPageRoute(builder: (_) => WeightPage());
      case AppRoutes.fitnessLevel:
        return MaterialPageRoute(builder: (_) => FitnessLevelScreen());
      case AppRoutes.goals:
        return MaterialPageRoute(builder: (_) => GoalsScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.explor:
        return MaterialPageRoute(builder: (_) => ExplorePage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case AppRoutes.myExercises:
        return MaterialPageRoute(builder: (_) => MyExercisesPage());
      case AppRoutes.myExercise:
        return MaterialPageRoute(builder: (_) => MyExercisePage());
      case AppRoutes.myWorkouts:
        return MaterialPageRoute(builder: (_) => MyWorkoutsPage());
      case AppRoutes.myPrograms:
        return MaterialPageRoute(builder: (_) => MyProgramsPage());
      case AppRoutes.tips:
        return MaterialPageRoute(builder: (_) => TipsPage());
      case AppRoutes.exercises:
        return MaterialPageRoute(builder: (_) => ExercisesPage());
      case AppRoutes.workouts:
        return MaterialPageRoute(builder: (_) => WorkoutsPage());
      case AppRoutes.programs:
        return MaterialPageRoute(builder: (_) => ProgramsPage());
      case AppRoutes.shop:
        return MaterialPageRoute(builder: (_) => ShopPage());
      case AppRoutes.program:
        return MaterialPageRoute(builder: (_) => ProgramDetailsPage());
      case AppRoutes.workout:
        return MaterialPageRoute(builder: (_) => WorkoutDetailsPage());
      case AppRoutes.exercise:
        return MaterialPageRoute(builder: (_) => ExerciseDetailsPage());
      case AppRoutes.shopItem:
        return MaterialPageRoute(builder: (_) => ShopItemPage());
      case AppRoutes.exercisesFilter:
        return MaterialPageRoute(builder: (_) => ExercisesFilterPage());
      case AppRoutes.workoutsFilter:
        return MaterialPageRoute(builder: (_) => WorkoutsFilterPage());
      case AppRoutes.programsFilter:
        return MaterialPageRoute(builder: (_) => ProgramsFilterPage());
      case AppRoutes.shopFilter:
        return MaterialPageRoute(builder: (_) => ShopFilterPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}