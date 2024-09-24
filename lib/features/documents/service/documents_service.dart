import '../../../shared/exports.dart';

abstract class DocumentsService {
  Future uploadDocumentForUser(File file);

  Future deleteDocumentForUser(Reference document);

  Future getUserDocuments();
}
