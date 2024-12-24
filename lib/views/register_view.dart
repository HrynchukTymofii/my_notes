import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              Color(0xFF240046), // Dark violet
              Color(0xFF5A189A), // Purple
              Color(0xFF9D4EDD), // Light purple
              Color(0xFF3C096C), // Darker purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
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
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false,);
                  }, 
                  child: const Text(
                    "Already registered? Login here!", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    )
                  )
                )
              ],
            ),
          ),
        ),
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