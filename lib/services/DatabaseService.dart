import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sam_maker/firebase_options.dart';

login(email, password) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Obtém a instância de FirebaseAuth.
  //FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    // Tenta realizar o login com email e senha fornecidos.
    await auth.signInWithEmailAndPassword(email: email, password: password);
    // Verifica se o usuário está logado.
    if (auth.currentUser != null) {
      print('login deu boa');
      return true;
    } else {
      print('Deu ruim');
      return false;
    }
  } catch (e) {
    return false;
  }
}

// Função para realizar o logout do usuário.
logout() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância de FirebaseAuth.
  FirebaseAuth auth = FirebaseAuth.instance;
  // Realiza o logout do usuário.
  auth.signOut();
}