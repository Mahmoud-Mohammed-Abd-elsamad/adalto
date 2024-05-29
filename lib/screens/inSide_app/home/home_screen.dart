import 'package:adalato_app/screens/inSide_app/home/event_class.dart';
import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Welcome, Adham'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.fitness_center),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsFromDay,
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
            ),
          ),
          ..._getEventsFromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(event.title),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "This week",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child:
                      Text("See Calendar", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(10.0),
              children: [
                _buildGridTile(context, "My Programs", Icons.fitness_center),
                _buildGridTile(context, "My Workouts", Icons.directions_run),
                _buildGridTile(context, "My Exercises", Icons.accessibility),
                _buildGridTile(context, "Tips", Icons.lightbulb_outline),
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
        currentIndex: 1, // Set the default index to Today
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget _buildGridTile(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        switch (icon) {
          case Icons.fitness_center:
            Navigator.pushNamed(context, AppRoutes.myPrograms);

          case Icons.directions_run:
            Navigator.pushNamed(context, AppRoutes.myWorkouts);

          case Icons.accessibility:
            Navigator.pushNamed(context, AppRoutes.myExercises);

          case Icons.lightbulb_outline:
            Navigator.pushNamed(context, AppRoutes.tips);
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.red),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Event"),
        content: TextField(
          controller: _eventController,
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              if (_eventController.text.isEmpty) return;
              if (selectedEvents[selectedDay] != null) {
                selectedEvents[selectedDay]!.add(
                  Event(_eventController.text),
                );
              } else {
                selectedEvents[selectedDay] = [Event(_eventController.text)];
              }
              Navigator.pop(context);
              _eventController.clear();
              setState(() {});
              return;
            },
          ),
        ],
      ),
    );
  }
}
