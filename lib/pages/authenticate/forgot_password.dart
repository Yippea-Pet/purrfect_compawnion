import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:purrfect_compawnion/services/auth.dart';
import 'package:purrfect_compawnion/shared/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        color: Colors.red[50],
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.lock, size: 60),
                SizedBox(height: 5.0,),
                Text(
                    'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(height: 5.0,),
                Text(
                  'Enter your email below to reset your password!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email!'
                          : null,
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.pink[400]),
                    ),
                    onPressed: () => forgotPassword(),
                    icon: Icon(Icons.mail),
                    label: Text(
                        'Send an email',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future forgotPassword() async {
    try {
      await _auth.resetPassword(emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password Reset Email Sent!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
