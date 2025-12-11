import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PenghuniListScreen extends ConsumerWidget {
  const PenghuniListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Penghuni')),
      body: const Center(child: Text('List of Penghuni will appear here')),
    );
  }
}
