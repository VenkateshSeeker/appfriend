import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../signup/signup.dart';
import '../home/home.dart';
import '../forgot_password/forgot_password.dart';
import '../welcome/welcome.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String? emailAddress;
  String? password;

  // Google Sign-In function
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GoogleBottomBar()),
      );
    } catch (e) {
      print('Google sign-in failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in failed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1833),
      body: SafeArea(
        child: Stack(
          children: [
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
                          "Log In",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: Color(0xFF162447),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  emailAddress = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: Color(0xFF162447),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                        email: emailAddress!,
                                        password: password!,
                                      );

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GoogleBottomBar()),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content:
                                              Text('No user found for that email.')),
                                        );
                                      } else if (e.code == 'wrong-password') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('Wrong password provided.')),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF00BF6D),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text("Login"),
                              ),
                              const SizedBox(height: 24),
                              // Social login buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => signInWithGoogle(context),
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                      child: Image.network(
                                        'https://developers.google.com/identity/images/g-logo.png',
                                        height: 38,
                                        width: 38,
                                      ),
                                    ),
                                    iconSize: 64,
                                    tooltip: 'Login with Google',
                                  ),
                                  const SizedBox(width: 32),
                                  IconButton(
                                    onPressed: () {
                                      // TODO: Implement Facebook login
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32,
                                      child: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                                        height: 38,
                                        width: 38,
                                      ),
                                    ),
                                    iconSize: 64,
                                    tooltip: 'Login with Facebook',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: Colors.white70),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  const TextSpan(
                                    text: "Don’t have an account? ",
                                    children: [
                                      TextSpan(
                                        text: "Sign Up",
                                        style:
                                        TextStyle(color: Color(0xFF00BF6D)),
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
