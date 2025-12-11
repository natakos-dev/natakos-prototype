import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/room_provider.dart';
import '../../data/models/room_type_model.dart';

class RoomTypeListScreen extends ConsumerWidget {
  const RoomTypeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomTypesAsync = ref.watch(roomTypeListProvider);

    // Watch controller for delete loading state
    final controllerState = ref.watch(roomControllerProvider);
    final isLoading = controllerState.isLoading;

    ref.listen(roomControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}')),
        );
      } else if (!next.isLoading && !next.hasError && next.hasValue) {
        // If delete successful, maybe show message?
        // Controller state is also used by Add/Edit, so we should be careful.
        // Usually safe to just show nothing if we don't know exact action,
        // or ensure controller resets.
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Daftar Tipe Kamar',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-room-type'),
        backgroundColor: const Color(0xFF1877F2),
        child: const Icon(Icons.add),
      ),
      body: roomTypesAsync.when(
        data: (roomTypes) {
          if (roomTypes.isEmpty) {
            return Center(
              child: Text(
                'Belum ada tipe kamar',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: roomTypes.length,
            separatorBuilder: (_, __) => const Gap(12),
            itemBuilder: (context, index) {
              final type = roomTypes[index];
              return _buildTypeCard(context, ref, type, isLoading);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildTypeCard(
      BuildContext context, WidgetRef ref, RoomTypeModel type, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.name,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(4),
                Text(
                  'Rp ${type.monthlyPrice.toStringAsFixed(0)} / ${type.paymentScheme}',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: const Color(0xFF1877F2)),
                ),
                const Gap(8),
                Wrap(
                  spacing: 8,
                  children: type.facilities
                      .take(3)
                      .map((f) => Chip(
                            label: Text(f,
                                style: GoogleFonts.poppins(fontSize: 10)),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ))
                      .toList(),
                )
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                context.push('/add-room-type', extra: type);
              } else if (value == 'delete') {
                _confirmDelete(context, ref, type);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [Icon(Icons.edit, size: 20), Gap(8), Text('Edit')],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    Gap(8),
                    Text('Hapus', style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, RoomTypeModel type) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Tipe Kamar?'),
        content: Text('Apakah anda yakin ingin menghapus tipe "${type.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx); // close dialog
              ref.read(roomControllerProvider.notifier).deleteRoomType(type.id);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
