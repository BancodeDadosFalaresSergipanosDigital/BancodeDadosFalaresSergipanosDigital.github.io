import 'package:flutter/material.dart';

class NotAprovated extends StatefulWidget {
  const NotAprovated({Key? key}) : super(key: key);

  @override
  State<NotAprovated> createState() => _NotAprovatedState();
}

class _NotAprovatedState extends State<NotAprovated> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Sua solicitação de acesso foi NEGADA!"),),
    );
  }
}
