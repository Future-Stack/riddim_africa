import 'package:get/get.dart';
import '../data/models/artist_document_model.dart';

class ArtistDocumentsController extends GetxController {
  final RxList<ArtistDocumentModel> documents =
      ArtistDocumentModel.mockDocuments.obs;

  void refreshDocuments() {
    documents.assignAll(ArtistDocumentModel.mockDocuments);
  }
}
