import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zoom_my_life_app/documents/documents_service.dart';

class FirebaseDocumentsService implements DocumentsService {
  @override
  Future<File?> pickFileFromDevice(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      File? pickedFile;

      if (result != null) {
        pickedFile = File(result.files.single.path!);
      }
      return pickedFile;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> uploadDocumentForUser(File file) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final fileName = file.path.split("/").last;
        final timestamp = DateTime.now().microsecondsSinceEpoch;
        final uploadRef =
            storageRef.child("$userId/uploads/$timestamp-$fileName");
        await uploadRef.putFile(file);
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> deleteDocumentForUser(Reference document) async {
    log("Documents service: Deleting document.");
    try {
      await document.delete();
      return true;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Reference>?> getUserDocuments() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final uploadsRefs = storageRef.child("$userId/uploads");
        final uploads = await uploadsRefs.listAll();
        return uploads.items;
      }
      return null;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
