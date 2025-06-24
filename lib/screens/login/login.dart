import 'package:flutter/material.dart';
import '../signup/signup.dart';
import '../home/home.dart';
import '../forgot_password/forgot_password.dart';
import '../welcome/welcome.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1833),
      body: SafeArea(
        child: Stack(
          children: [
            const AnimatedStarField(), // Animated star field background for consistency
            LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Removed loginscreen.png image for a cleaner look
                        Text(
                          "Log In",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    Colors.white, // Ensure visible on dark bg
                              ),
                        ),
                        const SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Username or Email',
                                  hintStyle: TextStyle(color: Colors.white70),
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
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.phone,
                                onSaved: (phone) {
                                  // Save it
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
                                onSaved: (passaword) {
                                  // Save it
                                },
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GoogleBottomBar(),
                                      ),
                                    );
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
                              // Social login buttons (Google & Facebook)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Google login icon button (official icon, larger)
                                  IconButton(
                                    onPressed: () {
                                      // TODO: Implement Google login
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32, // larger size
                                      child: Image.network(
                                        'https://developers.google.com/identity/images/g-logo.png',
                                        height: 38,
                                        width: 38,
                                      ),
                                    ),
                                    iconSize: 64, // make the tap area larger
                                    tooltip: 'Login with Google',
                                  ),
                                  const SizedBox(width: 32),
                                  // Facebook login icon button (larger)
                                  IconButton(
                                    onPressed: () {
                                      // TODO: Implement Facebook login
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 32, // larger size
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
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  const TextSpan(
                                    text: "Don’t have an account? ",
                                    children: [
                                      TextSpan(
                                        text: "Sign Up",
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
