import 'package:flutter/material.dart';
import 'package:jobapp/logIn.dart';
import 'package:jobapp/model/request/signuprequstmodel.dart';
import 'package:jobapp/service/helper/authhelper.dart';

class signUpNotfier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  userSignUp(BuildContext context, Signupmodel model) {
    AuthHelper.SignUp(model).then((response) => {
      if(response){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('signup sucessfull'),
          ),
        ),
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LogIn()))
      }else (){
 ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('update faild'),
            ),
          );
      }
    });
  }
}
