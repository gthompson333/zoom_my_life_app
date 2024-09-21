import '../../../shared/exports.dart';

abstract class DocumentsService {
  Future pickFileFromDevice(BuildContext context);

  Future uploadDocumentForUser(File file);

  Future deleteDocumentForUser(Reference document);

  Future getUserDocuments();
}
