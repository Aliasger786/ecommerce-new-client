import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/bottom_bar.dart';
import '../../../providers/user_provider.dart';
import '../../admin/screens/admin_screen.dart';
import '../../home/screens/home_screen.dart';
import '../services/auth_service.dart';
import 'package:telephony/telephony.dart';

class Otp extends StatefulWidget {
  var phone,cphone,verificationcode;
  Otp({required this.verificationcode,required this.phone,required this.cphone});

  @override
  _OtpState createState() => _OtpState(p1: this.phone,p2: this.cphone);
}

class _OtpState extends State<Otp> {
  var p1,p2;
  var otpcode;
  TextEditingController textEditingController = TextEditingController();
  final AuthService authService = AuthService();
  Telephony telephony = Telephony.instance;

  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address); //+977981******67, sender nubmer
        print(message.body); //Your OTP code is 34567
        print(message.date); //1659690242000, timestamp
        String sms = message.body.toString();
        otpcode=sms.substring(0,6);
        Fluttertoast.showToast(
            msg: otpcode,

            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,

            backgroundColor: Colors.red,
            textColor: Colors.white

        );
        textEditingController.text=otpcode;
      },
      listenInBackground: false,
    );
    super.initState();
  }
  String currentText = "";
  _OtpState({required this.p1,required this.p2});
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.purple);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child:Lottie.asset('assets/otp.json'),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "We have sent a verification code to",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              )
              ,
              SizedBox(
                height: 10,
              ),
              Text(
                '${p2}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
              ,
              SizedBox(
                height: 28,
              ),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.purple.shade50,
                enableActiveFill: true,
                controller: textEditingController,
                onCompleted: (v) async {
                  PhoneAuthCredential cred=PhoneAuthProvider.credential(verificationId: widget.verificationcode, smsCode: v);
                  try{
                    UserCredential ucred= await FirebaseAuth.instance.signInWithCredential(cred);
                    if(ucred.user != null){

                      authService.signInUserbyPhone(
                          context: context,
                          phone: p1.toString()
                      );

                    }
                  } on FirebaseAuthException catch(ex){
                    Fluttertoast.showToast(
                        msg: ex.code.toString(),

                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,

                        backgroundColor: Colors.red,
                        textColor: Colors.white
                    );

                  }



                },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),

              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Try again",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );


  }



}
