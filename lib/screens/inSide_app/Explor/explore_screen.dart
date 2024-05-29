
import 'dart:developer';

import 'package:adalato_app/models/shop_model.dart';
import 'package:adalato_app/models/workout_model.dart';
import 'package:adalato_app/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../models/excersise_model.dart';
import '../../../models/programs_model.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var image =
      "https://firebasestorage.googleapis.com/v0/b/adalato-app.appspot.com/o/background.jpg?alt=media&token=1f0d329f-b8fd-4f4c-b0e8-3c56f64cf88e";

  late String name;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? user;
  final CollectionReference _exercisesCollectionRef =
  FirebaseFirestore.instance.collection('exercises');
  final CollectionReference _programsCollectionRef =
  FirebaseFirestore.instance.collection('programs');
  final CollectionReference _shopitemsCollectionRef =
  FirebaseFirestore.instance.collection('shop_items');
  final CollectionReference _workoutsCollectionRef =
  FirebaseFirestore.instance.collection('workouts');


  List<ExerciseModel> exercisesTitles = [];
  List<ProgramModel> programsTitles = [];
  List<WorkoutModel> workoutsTitles = [];
  List<ShopItemModel> shopTitles = [];

  @override
  void initState() {
    log("fetchTitles >>>>>>>>>>>initStare>>>>>>>>>>>>>>>>>>>>> catch error ");

    name = "";
    user = auth.currentUser;
    fetchData();
    fetchExercisesTitles();
    fetchProgramsTitles();
    fetchWorkoutTitles();
    fetchShopTitles();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Explore'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            color: Colors.grey,
            // TODO Replace with image from assets
            // child: Image.asset('assets/your_image.jpg', fit: BoxFit.cover),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                _buildSection(context, 'Programs',
                    programsTitles.map((e) => e.title).toList(), image),
                _buildSection(context, 'Workouts',
                    workoutsTitles.map((e) => e.title).toList(),
                    image),
                _buildSection(
                    context, 'Exercises',exercisesTitles.map((e) => e.exerciseTitle).toList(), image),
                _buildSection(context, 'Shop', shopTitles.map((e) => e.category).toList(), image),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // Set the default index to Explore
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, AppRoutes.explor);
              break;
            case 1:
              Navigator.pushNamed(context, AppRoutes.home);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.profile);
              break;
          }
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> titles,
      String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  switch (title) {
                    case 'Programs':
                      Navigator.pushNamed(context, AppRoutes.programs);
                    case 'Workouts':
                      Navigator.pushNamed(context, AppRoutes.workouts);
                    case 'Exercises':
                      Navigator.pushNamed(context, AppRoutes.exercises);
                    case 'Shop':
                      Navigator.pushNamed(context, AppRoutes.shop);
                  }
                },
                child: Text('See all', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Implement item click functionality here
                    print('$title Item $index');
                  },
                  child: Container(
                    decoration:BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      )
                    ) ,
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: Text(
                        '${titles[index]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Replace with image from assets
                    // child: Image.asset('assets/your_image.jpg', fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    if (user == null) return;
    try {
      DocumentSnapshot doc =
      await fireStore.collection("users").doc(user!.uid).get();
      if (doc.exists) {
        setState(() {
          name = doc.get("name");
        });
      } else {
        setState(() {
          name = "User";
        });
      }
    } catch (e) {
      print("ERROR " + e.toString());
    }
  }

  Future<void> fetchExercisesTitles() async {
    log(
        "fetchTitles >>>>>>>>>>>>>>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${exercisesTitles
            .length}");

    try {
      QuerySnapshot querySnapshot = await _exercisesCollectionRef.get();

      setState(() {
        exercisesTitles = querySnapshot.docs
            .map((doc) => ExerciseModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${exercisesTitles
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }

  Future<void> fetchProgramsTitles() async {
    log(
        "fetchTitles >>>>>>>>>>>>>fetchProgrmasTitles>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${programsTitles
            .length}");

    try {
      QuerySnapshot querySnapshot = await _programsCollectionRef.get();

      setState(() {
        programsTitles = querySnapshot.docs
            .map((doc) => ProgramModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>fetchProgrmasTitles>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${programsTitles
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>fetchProgrmasTitles>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }

  Future<void> fetchWorkoutTitles() async {
    log(
        "fetchTitles >>>>>>>>>>>>>fetchWorkoutTitles>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${workoutsTitles
            .length}");

    try {
      QuerySnapshot querySnapshot = await _workoutsCollectionRef.get();

      setState(() {
        workoutsTitles = querySnapshot.docs
            .map((doc) => WorkoutModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>fetchWorkoutTitles>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${workoutsTitles
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>fetchWorkoutTitles>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }

  Future<void> fetchShopTitles() async {
    log(
        "fetchTitles >>>>>>>>>>>>>fetchShopTitles>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${shopTitles
            .length}");

    try {
      QuerySnapshot querySnapshot = await _shopitemsCollectionRef.get();

      setState(() {
        shopTitles = querySnapshot.docs
            .map((doc) => ShopItemModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>fetchShopTitles>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${shopTitles
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>fetchShopTitles>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }
}
