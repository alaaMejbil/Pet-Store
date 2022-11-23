import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled15/Model/PetModel.dart';
import 'package:image_picker/image_picker.dart';

class PetProvider extends ChangeNotifier {
  List<PetModel> allPets = [];
  String? authToken;
  String? userId;
  bool isLoading = false;
  bool isLoadingAddScreen = false;
  List<XFile> images = [];
  final ImagePicker _picker = ImagePicker();

  void getData(String? token, String? uId, List<PetModel> allPets) {
    this.allPets = allPets;
    userId = uId;
    authToken = token;

    notifyListeners();
  }

  Future<void> fetchAllPets() async {
    const url =
        "https://pets-store-6f3d1-default-rtdb.firebaseio.com/pets.json";

    String urlMyFavoritesItem =
        'https://pets-store-6f3d1-default-rtdb.firebaseio.com/userFavoraties/$userId.json';
    try {
      isLoading = true;
      // get All Pets
      final res = await http.get(Uri.parse(url));
      Map<String, dynamic> extractData = jsonDecode(res.body);
      print(res.body);

      // get My Favorites Item
      final resFavorites = await http.get(Uri.parse(urlMyFavoritesItem));
      final extractFavData = jsonDecode(resFavorites.body);

      print(resFavorites.body);
      List<PetModel> tempList = [];
      extractData.forEach((petId, petItem) {
        tempList.add(
            PetModel.fromJson(petItem, extractFavData[petId] ?? false, petId));
      });
      allPets = tempList.reversed.toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  List<PetModel> getPetsByCategory(int selectedCategoryIndex) {
    String categoryName = '';

    switch (selectedCategoryIndex) {
      case 0:
        categoryName = 'All';
        return allPets;
      case 1:
        categoryName = "Dog";
        break;
      case 2:
        categoryName = "Cat";
        break;
      case 3:
        categoryName = "Parrot";
        break;
      case 4:
        categoryName = "Rabbit";
        break;
      case 5:
        categoryName = "Fish";
        break;
      case 6:
        categoryName = "Turtle";
        break;
      case 7:
        categoryName = "Other";
        break;
    }

    return allPets.where((pet) => pet.petType == categoryName).toList();
  }

  List<PetModel> getMyFavoriteItems() {
    List<PetModel> myFavoritePets =
        allPets.where((element) => element.isFavorite!).toList();
    return myFavoritePets;
  }

  Future<void> toggleFavoriteStatus(PetModel pet) async {
    String url =
        'https://pets-store-6f3d1-default-rtdb.firebaseio.com/userFavoraties/$userId/${pet.id}.json';
    // toggle favorite status in Frontend
    final oldStatus = pet.isFavorite;
    int itemIndex = allPets.indexWhere((element) => element.id == pet.id);

    allPets[itemIndex].isFavoriteSetValue(!pet.isFavorite!);
    notifyListeners();

    // toggle favorite status in Backend
    try {
      final res =
          await http.put(Uri.parse(url), body: json.encode(pet.isFavorite!));
      if (res.statusCode >= 400) {
        //an Error happened
        allPets[itemIndex].isFavoriteSetValue(oldStatus!);
      }
    } catch (e) {
      print(e.toString());
      allPets[itemIndex].isFavoriteSetValue(oldStatus!);
    }
  }

  Future<List<XFile>> pickImages() async {
    //images = (await _picker.pickMultiImage())!;
    List<XFile>? temp = await _picker.pickMultiImage(imageQuality: 50);
    temp!.forEach((element) {
      images.add(element);
    });
    notifyListeners();
    return images;
  }

  Future<List<String>> uploadImages() async {
    List<String> imagesUrl = [];
    await FirebaseAuth.instance.signInAnonymously();

    try {
      for (var image in images) {
        print('Upload image : ${image.name}');
        final ref = FirebaseStorage.instance
            .ref()
            .child('pet_images')
            .child(image.path);

        await ref.putFile(File(image.path));
        final url = await ref.getDownloadURL();
        imagesUrl.add(url);
        print(url);
      }
    } catch (e) {
      print(e.toString());
      isLoadingAddScreen = false;
    }

    notifyListeners();
    return imagesUrl;
  }

  void clearAllImages() {
    images = [];
    notifyListeners();
  }

  // Add New Pet Process
  Future<void> addNewPet(PetModel newPet) async {
    isLoadingAddScreen = true;
    notifyListeners();
    print('uploading images .......');
    List<String> albumImagesUrl = await uploadImages();

    albumImagesUrl.forEach((element) {
      print(element);
    });

    print('add New Pet ............');
    const url =
        "https://pets-store-6f3d1-default-rtdb.firebaseio.com/pets.json";

    try {
      // add to firebase
      final res = await http
          .post(Uri.parse(url),
              body: jsonEncode({
                "age": newPet.age,
                "creatorBy": newPet.creatorBy,
                "description": newPet.description,
                "imageUrl": albumImagesUrl[0],
                "ownerName": newPet.ownerName,
                "ownerPhone": newPet.ownerPhone,
                "petName": newPet.petName,
                "price": newPet.price,
                "sex": newPet.sex,
                "weight": newPet.weight,
                "album": albumImagesUrl,
                "petType": newPet.petType,
              }))
          .then((response) {
        //add to state array
        allPets.insert(
          0,
          PetModel(
              id: jsonDecode(response.body)['name'],
              petName: newPet.petName,
              description: newPet.description,
              age: newPet.age,
              price: newPet.price,
              sex: newPet.sex,
              ownerName: newPet.ownerName,
              ownerPhone: newPet.ownerPhone,
              imageUrl: albumImagesUrl[0],
              creatorBy: newPet.creatorBy,
              weight: newPet.weight,
              album: albumImagesUrl,
              petType: newPet.petType,
              isFavorite: false),
        );

        isLoadingAddScreen = false;
        //Toast.show('Added Successfully');
        notifyListeners();
      });
    } catch (e) {
      isLoadingAddScreen = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
