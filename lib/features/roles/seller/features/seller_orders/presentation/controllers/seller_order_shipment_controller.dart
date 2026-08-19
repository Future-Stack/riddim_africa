import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SellerOrderShipmentController extends GetxController {
  final Rx<DateTime> packageDate = DateTime.now().obs;
  final TextEditingController estimatedDeliveryController =
      TextEditingController(text: '2-3 days');
  final TextEditingController notesController = TextEditingController();

  final RxBool isUndamagedChecked = true.obs;
  final RxBool isSecurelyWrappedChecked = true.obs;
  final RxBool isOrderIdWrittenChecked = true.obs;

  String get formattedPackageDate =>
      DateFormat('dd MMM yyyy').format(packageDate.value);

  @override
  void onClose() {
    estimatedDeliveryController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void pickPackageDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: packageDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFBB483D),
              onPrimary: Colors.white,
              surface: Color(0xFF22140A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      packageDate.value = picked;
    }
  }

  void toggleUndamaged() =>
      isUndamagedChecked.value = !isUndamagedChecked.value;
  void toggleSecurelyWrapped() =>
      isSecurelyWrappedChecked.value = !isSecurelyWrappedChecked.value;
  void toggleOrderIdWritten() =>
      isOrderIdWrittenChecked.value = !isOrderIdWrittenChecked.value;

  bool get canConfirm =>
      isUndamagedChecked.value &&
      isSecurelyWrappedChecked.value &&
      isOrderIdWrittenChecked.value;
}
