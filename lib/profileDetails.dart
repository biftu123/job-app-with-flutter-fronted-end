import 'dart:io';

import 'package:flutter/material.dart';

import 'package:jobapp/controller/imageUploader.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/model/request/userupdaterequstmodel.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController location = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  List<TextEditingController> skillsControllers =
      List.generate(5, (index) => TextEditingController());

  @override
  void dispose() {
    super.dispose();
    location.dispose();
    phoneNumber.dispose();
    for (var controller in skillsControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageprovider = Provider.of<imageUploader>(context);
    return Scaffold(
      body: Consumer<logInNotfier>(
        builder: (context, logInNotifier, _) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Profile Details",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Consumer<imageUploader>(
                      builder: (context, imageUploader, child) {
                        return GestureDetector(
                          onTap: () {
                            imageUploader.imageFil.clear();
                            imageUploader.pickImage();
                          },
                        child: CircleAvatar(
    backgroundColor: Colors.blueAccent,
    backgroundImage: imageUploader.imagePath != null
        ? FileImage(File(imageUploader.imagePath!))
        : null,
  ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: location,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          hintText: 'Enter location',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneNumber,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Professional Skills",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      for (var i = 0; i < 5; i++) ...[
                        TextFormField(
                          controller: skillsControllers[i],
                          decoration: InputDecoration(
                            hintText: 'Professional Skill',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a professional skill';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            List<String> skills = [];
                            for (var i = 0; i < 5; i++) {
                              skills.add(skillsControllers[i].text);
                            }
                            UserupdaterequstModel model = UserupdaterequstModel(
                              location: location.text,
                              skill: skills,
                              phonenumber: phoneNumber.text,
                              profile: imageprovider.imageUrl.toString(),
                            );
                            logInNotifier.updateuser(context, model);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          child: Center(child: Text('Save')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}