import 'package:cloud_firestore/cloud_firestore.dart';
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

// Função para registrar um novo usuário.
register(email, password, name) async {
  try{
    // Inicializa o Firebase.
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // Obtém a instância de FirebaseAuth.
    FirebaseAuth auth = FirebaseAuth.instance;
    // Cria um novo usuário com email e senha fornecidos.
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // Chama a função para registrar as informações  do usuário no FireStore
    registerInfo(
      user.user!.uid,
      name,
      email,
    );
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
  }
}

// Função para registrar as informações adicionais do usuário no Firestore.
registerInfo(uid, name, email) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Adiciona as informações do usuário no Firestore.
  await db.collection('Users').doc(uid).set(
    {
      'name': name,
      'email': email,
    },
  );
}

// Função para obter as informações do usuário do Firestore.
getUser() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Obtém o usuário atualmente logado.
  var checkUser = FirebaseAuth.instance.currentUser;
  // Obtém as informações do usuário do Firestore.
  var user = await db.collection('Users').doc(checkUser!.uid).get();
  // Retorna as informações do usuário.
  return user;
}

// Função para excluir o usuário e suas informações do Firestore.
deleteUser() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Obtém a instância de FirebaseAuth.
  var auth = FirebaseAuth.instance;
  // Exclui as informações do usuário do Firestore.
  await db.collection('Users').doc(auth.currentUser!.uid).delete();
  // Exclui o usuário.
  await auth.currentUser!.delete();
}

// Função para editar as informações do usuário no Firestore.
editUser(name, email) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância de FirebaseAuth.
  FirebaseAuth user = FirebaseAuth.instance;
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Define as novas informações do usuário no Firestore.
  await db.collection('Users').doc(user.currentUser!.uid).set({
    'name': name,
    'email': email,
  });
}