import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // Konstruktor für die [AuthRepository]
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  // Methode zum Abrufen des aktuellen Firebase-Benutzers und zum Neuladen des Benutzerstatus
  User? getCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    if (null != user) {
      user.reload();
    }
    return user;
  }

  // Methode zum Anmelden mit Google
  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (null == googleUser) throw Exception("Kein Google-Benutzer");
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return _firebaseAuth.signInWithCredential(credential);
  }

  // Methode zum Abmelden des Benutzers von [Firebase] und [GoogleSignIn]
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
