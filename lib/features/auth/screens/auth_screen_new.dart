import 'dart:developer';

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
/*import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';*/
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/auth_service.dart';
import 'auth_screen.dart';
import 'otp.dart';
/*import 'otp.dart';*/

class SecondRoute extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<SecondRoute> {
  var inputText = "";
  var cphone="";
  // ignore: prefer_typing_uninitialized_variables
  var uemail="";
  var uname="";
  var uphone="";
  var femail="";
  var fname="";
  var fphone="";
  final AuthService authService = AuthService();
  bool otpsent=false;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return

      AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark

          ),
          child:Scaffold(
            body:Stack(
                children: <Widget>[

            Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/background1.jpg'),
              fit: BoxFit.cover)
      ),
    ),
    Container(
    decoration: BoxDecoration(
    color: Color.fromRGBO(127, 139, 248, 0.76),

    ),
    ),

            Container(
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        new Center(

                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child:Center( child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child:   IntlPhoneField(

                                      textAlignVertical: TextAlignVertical.center,
                                      controller: _controller,


                                      onChanged: (phone) {
                                        setState(() {
                                          inputText = phone.number ;
                                          cphone=phone.completeNumber;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Enter Phone Number',
                                        suffixIcon: hidingIcon(),
                                        hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(9.0),
                                          borderSide: BorderSide.none,
                                        ),


                                        contentPadding: EdgeInsets.all(15.0),

                                      ),
                                      style: TextStyle(fontSize: 16, color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),


                                      onCountryChanged: (country) {
                                        print('Country changed to: ' + country.name);
                                      },
                                    ),
                                    // ignore: deprecated_member_use

                                  ),
                                  // ignore: deprecated_member_use
                                  SizedBox(
                                    height:15.0,
                                  ) ,
                                  // ignore: deprecated_member_use
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tightFor(width: 300, height: 45),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                            ))
                                        ,backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                                        padding: MaterialStateProperty.all(EdgeInsets.all(13)),
                                      ),
                                      onPressed: showToast,

                                      child: Text("Send OTP",style: TextStyle(
                                          fontSize: 16)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  _divider(),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children:  <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(6),
                                          primary: Colors.white,
                                        ),

                                        child: Image.asset(
                                          'assets/images/google-icon-new.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                        onPressed:() async {
                                          await signInWithGoogle();
                                          setState(() {

                                          });
                                        } ,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(6),
                                          primary: Color(0xff1877f2),
                                        ),
                                        child: Image.asset(
                                          'assets/images/facebook_icon.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                        onPressed: () async {
                                          await signInWithFacebook();
                                          setState(() {

                                          });
                                        },
                                      ),

                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(6),
                                          primary: Colors.white,
                                        ),
                                        child: Image.asset(
                                          'assets/images/envelope.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>AuthScreen() ));
                                        },
                                      ),


                                    ],
                                  ),




                                ],
                              )

                              )
                              ,)

                        )
                        ,

                      ],
                    ))),
            ]),
           )
      );
  }

  Widget? hidingIcon() {
    if (inputText.length > 0) {
      return IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.red,
          ),
          splashColor: Colors.redAccent,
          onPressed: () {
            setState(() {
              _controller.clear();
              inputText = "";
            });
          });
    } else {
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    uemail=googleUser.email.toString();
    uname=googleUser.displayName!.toString();
    uphone="";
    if(uemail.isEmpty)
    {
      Fluttertoast.showToast(
          msg: "Some error occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Colors.white,
          textColor: Colors.red
      );
    }
    else{

      Fluttertoast.showToast(

          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Colors.white,
          textColor: Colors.red, msg: uemail
      );
      authService.signInUserbyEmail(context: context, email: uemail.trim(), name: uname.trim(), phone: uphone.toString().trim());

    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final userData = await FacebookAuth.instance.getUserData(fields: "name,email");
    if(userData["email"].toString()!=""){
      Fluttertoast.showToast(
          msg: userData["email"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Colors.white,
          textColor: Colors.red
      );
      femail=userData["email"].toString().trim();
      fname=userData["name"].toString().trim();
      fphone="";
      authService.signInUserbyEmail(context: context, email: femail, name: fname, phone: fphone.trim());
    }
    else{
      Fluttertoast.showToast(
          msg: "some error occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Colors.white,
          textColor: Colors.red
      );

    }

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  void showToast() async {
    if(inputText.length == 10){
      await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: cphone,
          verificationCompleted: (credential){ },
          verificationFailed: (ex){log(ex.code.toString());},
          codeSent: (verificationID,resendtoken ){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>Otp(verificationcode: verificationID,phone: inputText,cphone: cphone ) ));
          },
          codeAutoRetrievalTimeout: (verificationID){},
          timeout: Duration(seconds: 60));
      // ignore: deprecated_member_use


    }
    else{
      Fluttertoast.showToast(
          msg: "Invaild Phone Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Colors.white,
          textColor: Colors.red
      );
    }

  }

}


Widget _divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              thickness: 0.5,
              color: Colors.white,
            ),
          ),
        ),
        Text('OR',style: TextStyle(color: Colors.white,),),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: Colors.white,
            ),
          ),
        ),

      ],
    ),
  );
}



