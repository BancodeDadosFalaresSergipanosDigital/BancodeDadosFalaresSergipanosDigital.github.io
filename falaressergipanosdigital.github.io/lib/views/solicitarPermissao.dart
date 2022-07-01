import 'package:flutter/material.dart';
import 'package:falaressergipanosdigital/views/aguardandoAprovacao.dart';
import '../resources/auth_methods.dart';
import 'login/widgets/inputFields.dart';

class SolicitarPermissao extends StatefulWidget {
  const SolicitarPermissao({Key? key}) : super(key: key);

  @override
  State<SolicitarPermissao> createState() => _SolicitarPermissaoState();
}

class _SolicitarPermissaoState extends State<SolicitarPermissao> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputField(controller: _name, size: size, icon: Icons.email),
            const SizedBox(height: 30),
            InputField(controller: _pass, size: size, icon: Icons.password),
            const SizedBox(height: 30),
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading ? const Center(child: CircularProgressIndicator()) : const Text('Registrar'),
                width: 300,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(nameUser: _name.text, password: _pass.text);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AguardandoAprovacao()));
    } else {
    }
  }
}
