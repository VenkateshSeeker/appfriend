import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/login.dart';
import '../welcome/welcome.dart';
import '../signup/signup_conf.dart'; // <-- Add this import

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? phoneNumber;
  String? password;
  String? otp;
  String? country;
  String? emailAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1833),
      body: SafeArea(
        child: Stack(
          children: [
            // Animated star field background
            const AnimatedStarField(),
            LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Full name',
                                  filled: true,
                                  fillColor: Color(0xFF162447),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                onSaved: (value) {
                                  fullName = value;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email address',
                                  filled: true,
                                  fillColor: Color(0xFF162447),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  emailAddress = value;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Phone',
                                        filled: true,
                                        fillColor: Color(0xFF162447),
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 16.0,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.phone,
                                      onSaved: (value) {
                                        phoneNumber = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      // TODO: Implement send OTP logic
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00BF6D),
                                      foregroundColor: Colors.white,
                                      shape: const StadiumBorder(),
                                      minimumSize: const Size(80, 48),
                                    ),
                                    child: const Text('Send'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Enter OTP',
                                        filled: true,
                                        fillColor: Color(0xFF162447),
                                        hintStyle: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 16.0,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (value) {
                                        otp = value;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      // TODO: Implement OTP verification logic
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00BF6D),
                                      foregroundColor: Colors.white,
                                      shape: const StadiumBorder(),
                                      minimumSize: const Size(80, 48),
                                    ),
                                    child: const Text('Verify'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Color(0xFF162447),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                obscureText: true,
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              DropdownButtonFormField(
                                items: countries,
                                icon: const Icon(
                                  Icons.expand_more,
                                  color: Colors.white,
                                ),
                                dropdownColor: const Color(0xFF162447),
                                style: const TextStyle(color: Colors.white),
                                onSaved: (value) {
                                  country = value;
                                },
                                onChanged: (value) {},
                                hint: const Text(
                                  'Country',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF162447),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      try {
                                        final credential = await FirebaseAuth
                                            .instance
                                            .createUserWithEmailAndPassword(
                                              email: emailAddress!,
                                              password: password!,
                                            );
                                        print("User created successfully");
                                        // Redirect to signup confirmation screen
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpConfScreen(),
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print(
                                            'The password provided is too weak.',
                                          );
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          print(
                                            'The account already exists for that email.',
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF00BF6D),
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text("Sign Up"),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  const TextSpan(
                                    text: "Already have an account? ",
                                    children: [
                                      TextSpan(
                                        text: "Log in",
                                        style: TextStyle(
                                          color: Color(0xFF00BF6D),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Demo country list
List<DropdownMenuItem<String>>? countries =
    [
      "Bangladesh",
      "Switzerland",
      'Canada',
      'Japan',
      'Germany',
      'Australia',
      'Sweden',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: TextStyle(color: Colors.white)),
      );
    }).toList();
