import 'package:doenlaod_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on firebase user
  User _userformfirebase(FirebaseUser user) {
    return user != null ? User(id: user.uid) : null;
  }

//auth change user system
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userformfirebase(user));
  }

//sign in anoy
  Future signinAnoy() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userformfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign with email and password
  Future signinwithemailndpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userformfirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }
//sign In with google
  Future signinwithgoogle() async {
    try {
      GoogleSignInAccount googleuser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleuser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //register with email and password
  Future registerwithemailndpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create a new user document withh the id
      // await DatabaseService(uid: user.uid).userupdatedata('0', 'new cafe member', 100);
      return _userformfirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }
  //sign-out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
