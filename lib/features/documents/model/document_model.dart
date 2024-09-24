import 'package:firebase_storage/firebase_storage.dart';

class DocumentModel {
  String name;
  String fileUrl;

  // TODO Generalize the firebase ref type here.
  Reference ref;

  DocumentModel(this.name, this.fileUrl, this.ref);
}
