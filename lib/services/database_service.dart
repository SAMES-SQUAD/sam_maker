import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

class UserNotifier extends ValueNotifier<Map<String, dynamic>> {
  UserNotifier() : super({});

  void updateUser(Map<String, dynamic> userData) {
    value = userData;
    notifyListeners();
  }
}

final userNotifier = UserNotifier();


// Função para obter as informações do usuário do Firestore.
getUser() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;

  var checkUser = FirebaseAuth.instance.currentUser;
  var user = await db.collection('Users').doc(checkUser!.uid).get();
  userNotifier.updateUser(user.data()!);
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

  userNotifier.updateUser({
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
    String normalizedTitle = normalizeStringForSearch(title);

    var querySnapshot = await db.collection('Games')
        .where('game_title_normalized', isGreaterThanOrEqualTo: normalizedTitle)
        .where('game_title_normalized', isLessThan: normalizedTitle + 'z')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> gamesList = [];
      querySnapshot.docs.forEach((doc) {
        gamesList.add(doc.data());
      });
      return gamesList;
    } else {
      print('No game found with title: $title');
      return [];
    }
  } catch (e, stackTrace) {
    print('$e');
    print(stackTrace);
    return [];
  }
}

String normalizeStringForSearch(String input) {
  return input.toLowerCase().replaceAll(RegExp(r'[àáâãäåAÁÀÂÄ]'), 'a')
                             .replaceAll(RegExp(r'[èéêëEÉÈÊ]'), 'e')
                             .replaceAll(RegExp(r'[ìíîïIÌÍÎ]'), 'i')
                             .replaceAll(RegExp(r'[òóôõöOÓÒÔÕ]'), 'o')
                             .replaceAll(RegExp(r'[ùúûüUÚÙÛ]'), 'u')
                             .replaceAll(RegExp(r'[ñÑN]'), 'n')
                             .replaceAll(RegExp(r'[çÇC]'), 'c');
}

// Retorna o step do jogo passado pelo nome.
getStepsByGame(String title) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    var querySnapshot = await db.collection('Games').where('game_title', isEqualTo: title).get();
    
    if (querySnapshot.docs.isNotEmpty) {
      var gameDoc = querySnapshot.docs.first;
      var gameData = gameDoc.data();
      // print('Game data: $gameData');

      var stepsCollection = await db.collection('Games').doc(gameDoc.id).collection('Steps').get();
      List<Map<String, dynamic>> steps = [];

      for (var stepDoc in stepsCollection.docs) {
        steps.add(stepDoc.data());
      }

      gameData['Steps'] = steps;
      return gameData;
    
    } else {
      print('No game found with title: $title');
      return null;
    }
  } catch (e, stackTrace) {
    print('$e');
    return null;
  }
}



//pra teste
//List respostaUsuario = ['Socialização', 'Coordenação motora'];

jogoRecomendado(respostaUsuario) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;
  
  QuerySnapshot gamesSnapshot = await db.collection('Games').where('tags', arrayContainsAny: respostaUsuario).get();

  print(gamesSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());

  return gamesSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

}