import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  late String _image;
  late String name;
  late String email;
  late String subscriptionDate;
  late String gender;
  late int weight;
  late int height;
  late String fitnessLevel;
  late List<String> goals;
  bool enableSounds = false;

  @override
  void initState() {
    super.initState();
    _image = '';
    name = 'Adham';
    email = 'example@gmail.com';
    subscriptionDate = '1-1-2025';
    gender = 'Male';
    weight = 71;
    height = 157;
    fitnessLevel = 'Intermediate';
    goals = ['Build Muscle', 'Lose Fat', 'Learn Techniques'];
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
      });
    }
  }

  void _editField(String field) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (field == 'name' || field == 'email') {
          return _buildEditTextDialog(field);
        } else if (field == 'weight' || field == 'height') {
          return _buildListWheelScrollViewDialog(field);
        } else if (field == 'fitnessLevel') {
          return _buildChecklistDialog(
              field, ['Beginner', 'Intermediate', 'Advanced']);
        } else if (field == 'goals') {
          return _buildChecklistDialog(field, [
            'Build strength',
            'Build muscle',
            'Lose fat',
            'Learn techniques'
          ]);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildEditTextDialog(String field) {
    TextEditingController controller = TextEditingController(
      text: field == 'name' ? name : email,
    );

    return AlertDialog(
      title: Text('Edit $field'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter new $field'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (field == 'name') {
                name = controller.text;
              } else {
                email = controller.text;
              }
            });
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  Widget _buildListWheelScrollViewDialog(String field) {
    int initialItem = field == 'weight' ? weight : height;
    return AlertDialog(
      title: Text('Edit $field'),
      content: Container(
        height: 200,
        child: ListWheelScrollView.useDelegate(
          controller: FixedExtentScrollController(initialItem: initialItem),
          itemExtent: 50,
          onSelectedItemChanged: (value) {
            setState(() {
              if (field == 'weight') {
                weight = value;
              } else {
                height = value;
              }
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              return Center(
                child: Text(
                  '$index',
                  style: TextStyle(fontSize: 24),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Done'),
        ),
      ],
    );
  }

  Widget _buildChecklistDialog(String field, List<String> options) {
    List<String> selectedOptions =
        field == 'fitnessLevel' ? [fitnessLevel] : goals;
    return AlertDialog(
      title: Text('Edit $field'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(options[index]),
                value: selectedOptions.contains(options[index]),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      if (field == 'fitnessLevel') {
                        selectedOptions = [options[index]];
                      } else {
                        selectedOptions.add(options[index]);
                      }
                    } else {
                      selectedOptions.remove(options[index]);
                    }
                  });
                },
              );
            },
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (field == 'fitnessLevel') {
                fitnessLevel = selectedOptions.first;
              } else {
                goals = selectedOptions;
              }
            });
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image.isEmpty
                          ? AssetImage('assets/avatar_placeholder.png')
                          : FileImage(File(_image)) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildSectionTitle('Personal information'),
            _buildInfoTile('Name', name),
            _buildInfoTile('Email', email),
            _buildInfoTile('Subscription Date', subscriptionDate),
            _buildSectionTitle('Workout\'s setting'),
            _buildSwitchTile('Enable sounds', enableSounds, (value) {
              setState(() {
                enableSounds = value;
              });
            }),
            _buildSectionTitle('Fitness information'),
            _buildInfoTile('Gender', gender),
            _buildInfoTile('Weight', '$weight kilograms'),
            _buildInfoTile('Height', '$height centimeters'),
            _buildInfoTile('Fitness level', fitnessLevel),
            _buildInfoTile('Goals', goals.join(', ')),
            _buildSectionTitle('Account'),
            _buildInfoTile('Change password', '******'),
            _buildInfoTile('Change email address', email),
            _buildSectionTitle('App'),
            _buildInfoTile('Rate App', ''),
            _buildInfoTile('Terms & Conditions', ''),
            _buildInfoTile('Contact us', ''),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your save changes logic here
              },
              child: Text('Save changes'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logout logic here
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () => _editField(title.toLowerCase().replaceAll(' ', '_')),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
