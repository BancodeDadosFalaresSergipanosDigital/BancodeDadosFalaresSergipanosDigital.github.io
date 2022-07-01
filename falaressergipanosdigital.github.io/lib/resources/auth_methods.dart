import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snapshot);
  }

  //sign up user
  Future<String> signUpUser({
    required String nameUser,
    required String password,
  }) async {
    String res = "Um erro ocorreu";
    try {
      if (nameUser.isNotEmpty || password.isNotEmpty) {
        // registrar usuário
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: nameUser, password: password);

        model.User user = model.User(nome: nameUser, uid: cred.user!.uid, approval_status: 1, user_type: 1);

        // adicionar usuario na base de dados
        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Verifique o email digitado.';
      } else if (err.code == 'weak-password') {
        res = 'Sua senha precisa ter pelo menos 6 caracteres';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // fazer login

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Um erro ocorreu.";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Preencha os campos corretamente";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'Usuario não encontrado.';
      } else if (err.code == 'wrong-password') {
        res = 'Senha incorreta';
      }
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
