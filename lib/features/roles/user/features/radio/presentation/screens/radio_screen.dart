import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../widgets/radio_chat_view.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(child: RadioChatView()),
    );
  }
}
