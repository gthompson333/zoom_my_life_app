import 'dart:developer';
import 'package:zoom_my_life_app/shared/exports.dart';

class DocumentsListScreen extends StatefulWidget {
  const DocumentsListScreen({super.key});

  @override
  State<DocumentsListScreen> createState() => _DocumentsListScreenState();
}

class _DocumentsListScreenState extends State<DocumentsListScreen> {
  late DocumentsService _documentsService;
  late AuthService _authService;
  List<Reference> _documents = [];

  @override
  void initState() {
    _documentsService = DocumentsService();
    _authService = FirebaseAuthService();
    _getUploadedDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Documents List",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _authService.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: _buildUI(),
      floatingActionButton: _uploadDocumentButton(context),
    );
  }

  Widget _uploadDocumentButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        File? selectedImage =
            await _documentsService.pickFileFromDevice(context);
        if (selectedImage != null) {
          bool success =
              await _documentsService.uploadDocumentForUser(selectedImage);
          if (success) {
            _getUploadedDocuments();
          }
        }
      },
      child: const Icon(
        Icons.upload,
      ),
    );
  }

  Widget _deleteDocumentButton(Reference docRef) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        bool success = await _documentsService.deleteDocumentForUser(docRef);
        if (success) {
          _getUploadedDocuments();
        }
      },
    );
  }

  Widget _buildUI() {
    if (_documents.isEmpty) {
      return const Center(
        child: Text("No documents uploaded yet."),
      );
    }
    return ListView.builder(
      itemCount: _documents.length,
      itemBuilder: (context, index) {
        Reference ref = _documents[index];
        return FutureBuilder(
          future: ref.getDownloadURL(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  leading: Image.network(snapshot.data!),
                  trailing: _deleteDocumentButton(ref),
                  title: Text(
                    ref.name,
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  void _getUploadedDocuments() async {
    List<Reference>? result = await _documentsService.getUserDocuments();

    if (result != null) {
      setState(
        () {
          _documents = result;
        },
      );
    }
  }

  @override
  Future<void> dispose() async {
    log("Disposing Documents Screen.");
    super.dispose();
  }
}
