import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:falaressergipanosdigital/resources/firestore_methods.dart';

class AguardandoAprovacao extends StatefulWidget {
  const AguardandoAprovacao({Key? key}) : super(key: key);

  @override
  State<AguardandoAprovacao> createState() => _AguardandoAprovacaoState();
}

class _AguardandoAprovacaoState extends State<AguardandoAprovacao> {
  FireStoreMethods fireStoreMethods = FireStoreMethods();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('approval_status', isEqualTo: 1).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            reverse: true,
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                width: size.width,
                child: Row(
                  children: [
                    Expanded(child: SizedBox(height: 20, child: Text("${(snapshot.data! as dynamic).docs[index].data()}"))),
                    TextButton(
                      onPressed: () => fireStoreMethods.liberarAcesso((snapshot.data! as dynamic).docs[index].data()['uid']),
                      child: const Text("Liberar", style: TextStyle(color: Colors.black)),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.greenAccent)),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      onPressed: () => fireStoreMethods.negarAcesso((snapshot.data! as dynamic).docs[index].data()['uid']),
                      child: const Text("Negar", style: TextStyle(color: Colors.black)),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
