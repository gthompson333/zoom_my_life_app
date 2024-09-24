import 'package:zoom_my_life_app/features/documents/model/document_model.dart';

import '../../../shared/exports.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit(this._documentsService) : super(InitialDocumentsState([]));

  final DocumentsService _documentsService;

  Future<void> uploadDocumentForUser(File file) async {
    emit(DocumentsOpInProgress([]));
    try {
      final success = await _documentsService.uploadDocumentForUser(file);
      if (!success) {
        emit(DocumentsOpFailed([]));
      } else {
        final documents = await _documentsService.getUserDocuments();
        emit(UploadDocumentSuccess(documents));
      }
    } catch (e) {
      emit(DocumentsOpFailed([]));
    }
  }

  // TODO replace the firebase 'Reference' type with a generic type.
  Future<void> deleteDocumentForUser(Reference document) async {
    emit(DocumentsOpInProgress([]));
    try {
      final success = await _documentsService.deleteDocumentForUser(document);
      if (!success) {
        emit(DocumentsOpFailed([]));
      } else {
        final documents = await _documentsService.getUserDocuments();
        emit(DeleteDocumentSuccess(documents));
      }
    } catch (e) {
      emit(DocumentsOpFailed([]));
    }
  }

  getDocumentsForUser() async {
    emit(DocumentsOpInProgress([]));
    try {
      final documents = await _documentsService.getUserDocuments();
      emit(GetDocumentsSuccess(documents));
    } catch (e) {
      emit(DocumentsOpFailed([]));
    }
  }
}
