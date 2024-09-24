import 'package:zoom_my_life_app/features/documents/bloc/documents_cubit.dart';
import 'package:zoom_my_life_app/shared/exports.dart';
import 'dart:developer';

class DocumentsListScreen extends StatefulWidget {
  const DocumentsListScreen({super.key});

  @override
  State<DocumentsListScreen> createState() => _DocumentsListScreenState();
}

class _DocumentsListScreenState extends State<DocumentsListScreen> {
  @override
  void initState() {
    context.read<DocumentsCubit>().getDocumentsForUser();
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
                context.read<AuthBloc>().add(LoggedOutAuthEvent());
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
        File? selectedFile = await pickFileFromDevice(context);
        if (selectedFile != null && context.mounted) {
          context.read<DocumentsCubit>().uploadDocumentForUser(selectedFile);
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
        context.read<DocumentsCubit>().deleteDocumentForUser(docRef);
      },
    );
  }

  Widget _buildUI() {
    return BlocBuilder<DocumentsCubit, DocumentsState>(
      builder: (context, state) {
        switch (state) {
          case DocumentsOpInProgress():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case DocumentsOpFailed():
            return const Center(
              child: Text("Documents operation failed."),
            );
          default:
            if (state.documents.isEmpty) {
              return const Center(
                child: Text("No documents uploaded yet."),
              );
            }
            return ListView.builder(
              itemCount: state.documents.length,
              itemBuilder: (context, index) {
                final documentModel = state.documents[index];
                return ListTile(
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  leading: Image.network(documentModel.fileUrl),
                  trailing: _deleteDocumentButton(documentModel.ref),
                  title: Text(
                    documentModel.name,
                  ),
                );
              },
            );
        }
      },
    );
  }

  @override
  Future<void> dispose() async {
    log("Disposing Documents Screen.");
    super.dispose();
  }
}
