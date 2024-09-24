import 'exports.dart';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';

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
