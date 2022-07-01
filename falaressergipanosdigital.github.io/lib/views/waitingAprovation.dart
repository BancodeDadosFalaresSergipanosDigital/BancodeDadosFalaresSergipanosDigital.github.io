import 'package:flutter/material.dart';

class WaitingAprovation extends StatefulWidget {
  const WaitingAprovation({Key? key}) : super(key: key);

  @override
  State<WaitingAprovation> createState() => _WaitingAprovationState();
}

class _WaitingAprovationState extends State<WaitingAprovation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Aguardando aprovação!"),
      ),
    );
  }
}
