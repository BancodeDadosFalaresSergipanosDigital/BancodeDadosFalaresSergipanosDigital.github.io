import 'package:flutter/material.dart';
import 'package:falaressergipanosdigital/views/listarDados/listarDados.dart';
import 'package:falaressergipanosdigital/views/login/widgets/inputFields.dart';
import '../../../resources/auth_methods.dart';
import '../solicitarPermissao.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ListarDados()));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF1FBCFD),
      body: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
          width: size.width * 0.6,
          height: size.height * 0.7,
          child: SizedBox(
            width: size.width * 0.6,
            height: size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(controller: _emailController, size: size, icon: Icons.email),
                const SizedBox(height: 30),
                InputField(controller: _passwordController, size: size, icon: Icons.password, obscureText: true),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: loginUser,
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                    child: Center(child: _isLoading ? const CircularProgressIndicator(color: Colors.black) : const Text('Entrar', style: TextStyle(color: Colors.white))),
                  ),
                ),
                TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SolicitarPermissao())),
                    child: const Text("Solicitar acesso"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
