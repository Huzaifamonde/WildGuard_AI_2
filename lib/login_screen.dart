import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'globals.dart';
import 'no_animal_detection.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  void _validateAndLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (isFromDeepLink && globalAnimalName != null) {
          // 🐾 Came via SMS link
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(animalName: globalAnimalName!),
            ),
          );
        } else {
          // 👣 Normal login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NoAnimalDetection(),


            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Login failed. Please try again.';
        if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
          message = 'No user found with that email.';
        } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
          message = 'Incorrect password.';
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFFF0F4F4),
      body: Stack(
        children: [
          Positioned(
            top: -30,
            right: -65,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF006D77).withOpacity(0.2),
              ),
              child: ClipOval(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Image.asset(
                        'assets/images/tiger.png',
                        fit: BoxFit.cover,
                        width: 340,
                        height: 340,
                      ),
                    ),
                    Container(
                      color: const Color(0xFF006D77).withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 380, left: 40, right: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006D77),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF006D77),
                        ),enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00AFB9)),
                      ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        alignLabelWithHint: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xFF00AFB9), width: 2),
                        ),
                        prefixIcon: Icon(Icons.email, color: Color(0xFF006D77)),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF006D77),
                        ),enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00AFB9)),
                      ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        alignLabelWithHint: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xFF00AFB9), width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF006D77)),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: _isLoading ? null : _validateAndLogin,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : const Color(0xFF00AFB9),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                              : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF023047),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00AFB9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
