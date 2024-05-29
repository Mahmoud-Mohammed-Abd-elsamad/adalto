import 'package:adalato_app/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/widgets/custome_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          await user.sendEmailVerification();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'uid': user.uid,
            'createdAt': Timestamp.now(),
          });

          Navigator.pushNamed(context, AppRoutes.gender);
          print('User registered and email verification sent');
        }
      } on FirebaseAuthException catch (e) {
        print('Error: ${e.message}');
      }
    } else {
      print('Form is invalid');
    }
  }

  Widget _buildSocialButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // TextFormField(
              //   controller: _nameController,
              //   focusNode: _nameFocusNode,
              //   decoration: const InputDecoration(labelText: 'Name'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your name';
              //     }
              //     return null;
              //   },
              //   textInputAction: TextInputAction.next,
              //   onFieldSubmitted: (_) {
              //     _emailFocusNode.requestFocus();
              //   },
              // ),
              CustomTextField(
                text: 'Nmae',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                text: "Email",
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),

              CustomTextField(
                text: "Password",
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                text: "Confirm Password",
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Register'),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: null,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.network(
                            "https://pngimg.com/uploads/google/google_PNG19635.png"),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.apple_outlined,
                          color: Colors.black,
                          size: 60,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.facebook_sharp,
                          color: Colors.blue,
                          size: 60,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // _buildSocialButton('Sign in with Google', const Color(0xFFDB4437)),
              // _buildSocialButton('Sign in with Facebook', const Color(0xFF4267B2)),
              // _buildSocialButton('Sign in with X', Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
