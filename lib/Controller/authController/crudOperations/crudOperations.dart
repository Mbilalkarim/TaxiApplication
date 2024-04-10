import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../Model/profileModel.dart';
import '../../../Model/responseModel.dart';
import '../../../utilities/debug.dart';
import '../../../utilities/getStorage.dart';
import '../auth_service.dart';
import 'firestorage_exception.dart';

class FirestoreServices {
  final _userCollection = FirebaseFirestore.instance.collection("user");

  Future<String> uploadImage(String storagePath, File file) async {
    try {
      String imgUrl = await _uploadFile(storagePath, file);
      return imgUrl;
    } catch (e) {
      throw StorageException("Error uploading image: $e");
    }
  }

  Future<ResponseModel> deleteAccount() async {
    try {
      String? userId = AuthService.firebase().currentUser?.id;
      WriteBatch batch = FirebaseFirestore.instance.batch();
      DocumentReference userDocRef = _userCollection.doc(userId);
      await deleteFile();
      batch.delete(userDocRef);
      await batch.commit();
      await FirebaseAuth.instance.currentUser?.delete();
      await FirebaseAuth.instance.signOut();
      return ResponseModel(true, 'Documents deleted successfully');
    } catch (e) {
      // An error occurred while deleting the documents
      return ResponseModel(false, 'Error deleting documents: $e');
    }
  }

  Future<String> _uploadFile(String storageName, File file) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("$storageName/${AuthService.firebase().currentUser?.id}.jpg");
      final TaskSnapshot uploadTask = await storageReference.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw StorageException("Error uploading file: $e");
    }
  }

  Future<String> uploadImageWeb(Uint8List fileBytes) async {
    try {
      String? userId = AuthService.firebase().currentUser?.id;
      String path = 'userImage/${userId}.jpg';
      String imgUrl = await _uploadFileWeb("$path", fileBytes);

      return imgUrl;
    } catch (e) {
      throw StorageException("Error uploading image: $e");
    }
  }

  Future<String> _uploadFileWeb(String path, Uint8List fileBytes) async {
    // Get reference to the Firebase storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref(path);

    try {
      // Upload the file to Firebase Storage
      await storageRef.putData(fileBytes);

      // Get the download URL of the uploaded file
      String downloadUrl = await storageRef.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return ''; // Return empty string if an error occurs
    }
  }

  Future<void> deleteFile() async {
    try {
      String? userId = AuthService.firebase().currentUser?.id;
      if (userId != null) {
        String storageFilePath = 'userImage/$userId.jpg'; // Specify the path to the specific file
        Reference storageRef = FirebaseStorage.instance.ref().child(storageFilePath);
        await storageRef.delete(); // Delete the specific file
        print('File $storageFilePath deleted successfully');
      }
    } catch (e) {
      print('Error deleting file: $e');
      throw StorageException("Error deleting file: $e");
    }
  }

  Future<ResponseModel> setUserData(UserModel user) async {
    try {
      await _userCollection.doc(AuthService.firebase().currentUser?.id).set({
        'userId': user.userId,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'emailAddress': user.emailAddress,
        'dateOfBirth': user.dateOfBirth,
        'phoneNumber': user.phoneNumber,
        'address': user.address,
        'zipCode': user.zipCode,
        'city': user.city,
        'imageUrl': user.imageUrl,
        'cnicNumber': user.cnicNumber,
        'cnicFrontUrl': user.cnicFrontUrl,
        'cnicBackUrl': user.cnicBackUrl,
        'licenseNo': user.licenseNo,
        'licenseUrl': user.licenseUrl,
        'isOwnVehicle': user.isOwnVehicle,
        'userType': user.userType,
      });
      storeUserData(user);
      return ResponseModel(true, 'User data added successfully!');
    } on FirebaseException catch (e) {
      return ResponseModel(true, 'Error Occurred ${e.code.replaceAll("-", " ")}');
    } catch (e) {
      return ResponseModel(true, 'Error Occurred $e');
    }
  }

  Future<bool> isCollectionExists() async {
    QuerySnapshot collectionSnapshot = await _userCollection.get();
    return collectionSnapshot.docs.isNotEmpty;
  }

  Future<bool> isDocumentExists() async {
    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(AuthService.firebase().currentUser?.id).get();
    return documentSnapshot.exists;
  }

  Future<UserModel> getUserData() async {
    try {
      debug("AuthService.firebase().currentUser?.id ${AuthService.firebase().currentUser?.id}");
      DocumentSnapshot documentSnapshot =
          await _userCollection.doc(AuthService.firebase().currentUser?.id).get();
      UserModel user = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      debug("we are user in ou t $user");
      return user;
    } on FirebaseException catch (e) {
      debug(e);
      return UserModel();
    } catch (e) {
      return UserModel();
    }
  }
}
