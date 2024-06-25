import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sam_maker/firebase_options.dart';

login(email, password) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.signOut();
}

// Função para registrar um novo usuário.
register(email, password, name) async {
  try{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseAuth auth = FirebaseAuth.instance;

    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;

  await db.collection('Users').doc(uid).set(
    {
      'name': name,
      'email': email,
    },
  );
}

// Função para obter as informações do usuário do Firestore.
getUser() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;

  var checkUser = FirebaseAuth.instance.currentUser;
  var user = await db.collection('Users').doc(checkUser!.uid).get();
  return user;
}

// Função para excluir o usuário e suas informações do Firestore.
deleteUser() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;

  var auth = FirebaseAuth.instance;

  await db.collection('Users').doc(auth.currentUser!.uid).delete();
  await auth.currentUser!.delete();
}

// Função para editar as informações do usuário no Firestore.
editUser(name, email) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth user = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Define as novas informações do usuário no Firestore.
  await db.collection('Users').doc(user.currentUser!.uid).set({
    'name': name,
    'email': email,
  });
}

// Função para obter todos os jogos cadastrados no Firestore.
getAllGames() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {

    var gamesCollection = await db.collection('Games').get();
    List<Map<String, dynamic>> games = [];

    for (var doc in gamesCollection.docs) {

      games.add(doc.data());
      print('Game: ${doc.data()}');

      var stepsCollection = await db.collection('Games').doc(doc.id).collection('Steps').get();

      for (var stepDoc in stepsCollection.docs) {
        print('Step: ${stepDoc.data()}');
      }

    }
    // Retorna a lista de jogos.
    print(games);
    return games;
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
    return [];
  }
}


// Retorna o jogo cadastrado no Firestore.
getGameByTitle(String title) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    // Cria uma query para buscar jogos pelo título.
    var querySnapshot = await db.collection('Games')
        .where('game_title', isEqualTo: title)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var gameData = querySnapshot.docs.first.data();
      print('Game data: $gameData');
      return gameData;
    } else {
      print('No game found with title: $title');
      return null;
    }
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
    return null;
  }
}

// Retorna o step do jogo passado pelo nome.
getStepsByGame(String title) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    // Cria uma query para buscar jogos pelo título.
    var querySnapshot = await db.collection('Games').where('game_title', isEqualTo: title).get();
    
    if (querySnapshot.docs.isNotEmpty) {
      var gameDoc = querySnapshot.docs.first;
      var gameData = gameDoc.data();
      print('Game data: $gameData');

      // Obter os passos associados a esse jogo.
      var stepsCollection = await db.collection('Games').doc(gameDoc.id).collection('Steps').get();
      List<Map<String, dynamic>> steps = [];

      for (var stepDoc in stepsCollection.docs) {
        steps.add(stepDoc.data());
        print('Step: ${stepDoc.data()}');
      }

      gameData['steps'] = steps;
      return gameData;
    
    } else {
      print('No game found with title: $title');
      return null;
    }
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
    return null;
  }
}
