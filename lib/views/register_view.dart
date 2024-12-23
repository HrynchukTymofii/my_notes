import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1D2671), // Deep blue
              Color(0xFFC33764), // Dark pink
              Color(0xFF0F9B8E), // Teal green
              Color(0xFF64379F), // Violet
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildGlassInputField(
                            controller: _email,
                            hintText: "Enter your email here",
                            icon: Icons.email,
                          ),
                          const SizedBox(height: 20),
                          _buildGlassInputField(
                            controller: _password,
                            hintText: "Enter your password here",
                            icon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          _buildGlassButton(
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                              try {
                                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                print(userCredential);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('Weak password');
                                } else if (e.code == 'email-already-in-use') {
                                  print('Email already used');
                                } else if (e.code == 'invalid-email') {
                                  print('Invalid email');
                                }
                              }
                            },
                            text: 'Register',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildGlassInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(51, 255, 255, 255), // Transparent white with alpha 0.2
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromARGB(77, 255, 255, 255)), // Transparent white with alpha 0.3
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0), // Black with alpha 0.1
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(51, 255, 255, 255), // Transparent white with alpha 0.2
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(77, 255, 255, 255)), // Transparent white with alpha 0.3
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0), // Black with alpha 0.1
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}