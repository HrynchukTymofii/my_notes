import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        child:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildGlassInputField(
              controller: _email,
              hintText: 'Enter your email here',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),
            _buildGlassInputField(
              controller: _password,
              hintText: 'Enter your password here',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            _buildGlassButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                }
              },
              text: 'Login',
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false,);
              }, 
              child: const Text(
                "Not registered? Register here!", 
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
        )))
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
        color: Color.fromARGB(51, 255, 255, 255), // Transparent white
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromARGB(77, 255, 255, 255)), // Transparent border
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0), // Subtle shadow
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
          color: Color.fromARGB(51, 255, 255, 255), // Transparent white
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(77, 255, 255, 255)), // Transparent border
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0), // Subtle shadow
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


