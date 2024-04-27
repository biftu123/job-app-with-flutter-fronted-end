
import 'package:flutter/material.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/model/request/upskill.dart';

import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  final List<String> skill;

  const UpdateProfile({
    Key? key,
    required this.skill,
  }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  List<TextEditingController> skillsControllers = [];

  @override
  void initState() {
    super.initState();

    // Initialize skillsControllers with initial values from widget.skill
    for (var i = 0; i < 5; i++) {
      final controller = TextEditingController(
        text: i < widget.skill.length ? widget.skill[i] : '',
      );
      skillsControllers.add(controller);
    }
  }

  @override
  void dispose() {
    super.dispose();

    for (var controller in skillsControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
        ),
        body: Consumer<logInNotfier>(
          builder: (context, logInNotfier, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: skillsControllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: skillsControllers[index],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            labelText: 'Skill ${index + 1}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    // Access the entered values from the text fields using 'skillsControllers'
                    // Perform necessary actions or validations
                    List<String> skills = [];
                    for (var i = 0; i < 5; i++) {
                      skills.add(skillsControllers[i].text);
                    }
                    Upskill model = Upskill(skill: skills);
                    logInNotfier.upskill(context, model);
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        ));
  }
}
