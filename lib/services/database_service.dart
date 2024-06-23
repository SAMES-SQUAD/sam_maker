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


// Função para obter todos os jogos cadastrados no Firestore.
getAllGames() async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    // Obtém a coleção de games do Firestore.
    var gamesCollection = await db.collection('Games').get();
    // Cria uma lista para armazenar os jogos.
    List<Map<String, dynamic>> games = [];
    // Itera sobre cada documento na coleção.
    for (var doc in gamesCollection.docs) {
      // Adiciona cada jogo à lista de jogos.
      games.add(doc.data());
    }
    // Retorna a lista de jogos.
    return games;
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
    return [];
  }
}

// Função para obter um jogo específico pelo título no Firestore.
getGameByTitle(String title) async {
  // Inicializa o Firebase.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Obtém a instância do FirebaseFirestore.
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    // Cria uma query para buscar jogos pelo título.
    var querySnapshot = await db.collection('Games')
        .where('game_title', isEqualTo: title)
        .get();
    // Verifica se há algum documento correspondente.
    if (querySnapshot.docs.isNotEmpty) {
      // Obtém os dados do primeiro jogo encontrado.
      var gameData = querySnapshot.docs.first.data();
      // Imprime os dados do jogo no console.
      print('Game data: $gameData');
      // Retorna os dados do jogo.
      return gameData;
    } else {
      // Retorna null se nenhum jogo foi encontrado.
      print('No game found with title: $title');
      return null;
    }
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
    return null;
  }
}
