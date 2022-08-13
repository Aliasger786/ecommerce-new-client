import 'dart:convert';

import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../features/auth/services/auth_service.dart';

final AuthService authService1 = AuthService();
final AuthService authService2 = AuthService();
void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      if("User with this email does not exist!"==jsonDecode(response.body)['msg'].toString())
        {

        }
      showSnackBar(context, "uyuyv");
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

void httpErrorHandle1({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required String phone
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      if("User with this phone does not exist!"==jsonDecode(response.body)['msg'].toString())
      {
authService1.signUpUserbyPhone(
    context: context,
    phone: phone.toString()
);
      }

      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

void httpErrorHandle2({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required String email,
  required String name,
  required String phone
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      if("User with this email does not exist!"==jsonDecode(response.body)['msg'].toString().trim())
      {
        authService1.signUpUserbyEmail(
            context: context,
            email: email.toString(),
            name: name.toString(),
          phone: phone.toString()
        );
      }


      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

void httpErrorHandle3({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required String email,
  required String name, required String phone
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
