import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zoom_my_life_app/features/documents/model/document_model.dart';
import 'package:zoom_my_life_app/features/documents/service/documents_service.dart';

class FirebaseDocumentsService implements DocumentsService {
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
  Future<List<DocumentModel>> getUserDocuments() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      List<DocumentModel> documentModels = <DocumentModel>[];

      if (userId != null) {
        // Fetch the Firebase upload items for the user.
        final uploadsRef =
            FirebaseStorage.instance.ref().child("$userId/uploads");

        final uploadItems = await uploadsRef.listAll();

        // Iterate through the Firebase upload items and construct a model object for each one.
        for (Reference uploadItem in uploadItems.items) {
          final uploadUrl = await uploadItem.getDownloadURL();
          documentModels
              .add(DocumentModel(uploadItem.name, uploadUrl, uploadItem));
        }
        return documentModels;
      }
      return documentModels;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
