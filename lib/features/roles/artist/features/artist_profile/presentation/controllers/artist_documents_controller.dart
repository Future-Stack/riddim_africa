import 'package:get/get.dart';
import '../../data/models/artist_document_model.dart';

class ArtistDocumentsController extends GetxController {
  final RxList<ArtistDocumentModel> documents = <ArtistDocumentModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDocuments();
  }

  void loadDocuments() {
    documents.assignAll(ArtistDocumentModel.mockDocuments);
  }

  ArtistDocumentModel? getDocumentById(String id) {
    return documents.firstWhereOrNull((d) => d.id == id);
  }
}
