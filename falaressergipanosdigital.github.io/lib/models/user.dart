import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final int approval_status;
  final String uid;
  final String nome;
  final int user_type;

  const User({
    required this.approval_status,
    required this.uid,
    required this.nome,
    required this.user_type,
  });

  Map<String, dynamic> toJson() => {
        "approval_status": approval_status,
        "uid": uid,
        "nome": nome,
        "user_type": user_type,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      approval_status: snapshot['approval_status'],
      uid: snapshot['uid'],
      nome: snapshot['nome'],
      user_type: snapshot['user_type'],
    );
  }
}
