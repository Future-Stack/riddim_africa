import 'package:get/get.dart';
import '../data/models/seller_document_model.dart';

class SellerDocumentsController extends GetxController {
  final RxList<SellerDocumentModel> documents =
      SellerDocumentModel.mockDocuments.obs;

  void refreshDocuments() {
    documents.assignAll(SellerDocumentModel.mockDocuments);
  }
}
