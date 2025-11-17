import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/network/abstract/base_firebase_service.dart';

class FirebaseAuthClass extends BaseFirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  bool isUserLoggedIn() {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    final userCredential =
        auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  @override
  void signOutUser() {
    auth.signOut();
  }

  @override
  Future<UserCredential> signupUserWithFirebase(
      String email, String password, String name) {
    final userCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  Future<void> sendPasswordResetLink(String email) async{
    try{
      await auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
    }
  }
}
