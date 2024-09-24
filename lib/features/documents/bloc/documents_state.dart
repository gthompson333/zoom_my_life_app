part of 'documents_cubit.dart';

sealed class DocumentsState {
  DocumentsState(this.documents);

  List<DocumentModel> documents = [];
}

final class InitialDocumentsState extends DocumentsState {
  InitialDocumentsState(super.documents);
}

final class UploadDocumentSuccess extends DocumentsState {
  UploadDocumentSuccess(super.documents);
}

final class DeleteDocumentSuccess extends DocumentsState {
  DeleteDocumentSuccess(super.documents);
}

final class GetDocumentsSuccess extends DocumentsState {
  GetDocumentsSuccess(super.documents);
}

final class DocumentsOpInProgress extends DocumentsState {
  DocumentsOpInProgress(super.documents);
}

final class DocumentsOpFailed extends DocumentsState {
  DocumentsOpFailed(super.documents);
}
