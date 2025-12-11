import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/tenant_model.dart';
import '../providers/tenant_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TenantDetailScreen extends ConsumerWidget {
  final TenantModel tenant;

  const TenantDetailScreen({super.key, required this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Parsing Data
    final profilePictureUrl = 'https://i.pravatar.cc/150?u=${tenant.id}';

    // Parse Emergency Contact
    String ecName = '-';
    String ecPhone = '-';
    if (tenant.emergencyContact != null &&
        tenant.emergencyContact!.isNotEmpty) {
      if (tenant.emergencyContact!.contains('(')) {
        final parts = tenant.emergencyContact!.split('(');
        ecName = parts[0].trim();
        ecPhone = parts[1].replaceAll(')', '').trim();
      } else {
        ecName = tenant.emergencyContact!;
      }
    }

    // Parse Room & Date from Notes (Stored as "Kamar: ID, Masuk: Date")
    String roomInfo = 'Belum Ada';
    String entryDate = '-';
    if (tenant.notes != null) {
      final notes = tenant.notes!;
      if (notes.contains('Masuk:')) {
        final parts = notes.split('Masuk:');
        entryDate = parts[1].trim();
      }
      if (notes.contains('Kamar:')) {
        // If we had the room name stored, it would be better.
        // For now, we might just see the ID.
        // Ideally, we should fetch the RoomModel by ID, but simpler to just show "Terisi".
        // Let's try to extract ID or simple text.
        roomInfo = 'Terisi';
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Light grey background
      appBar: AppBar(
        title: Text(
          'Profil Penghuni',
          style: GoogleFonts.poppins(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87, size: 20),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              // Show delete confirmation
              showDialog(
                  context: context,
                  builder: (chatContext) => AlertDialog(
                        title: const Text('Hapus Penghuni?'),
                        content: const Text(
                            'Data yang dihapus tidak dapat dikembalikan.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(chatContext),
                              child: const Text('Batal')),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(chatContext);
                                // Use Provider to delete
                                await ref
                                    .read(tenantControllerProvider.notifier)
                                    .deleteTenant(tenant.id);
                                if (context.mounted)
                                  context.pop(); // Back to list
                              },
                              child: const Text('Hapus',
                                  style: TextStyle(color: Colors.red))),
                        ],
                      ));
            },
          ),
          const Gap(8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 2. Head Profile Section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(profilePictureUrl),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const Gap(16),
                  Text(
                    tenant.fullName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Text(
                    tenant.phoneNumber,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Gap(24),

                  // Quick Actions (Call/WA)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildQuickAction(Icons.call, 'Telepon', Colors.blue),
                      const Gap(16),
                      _buildQuickAction(
                          Icons.message, 'WhatsApp', Colors.green),
                    ],
                  )
                ],
              ),
            ),

            const Gap(32),

            // 3. Information Cards
            _buildInfoCard(
                title: 'Biodata Diri',
                icon: Icons.person_outline,
                children: [
                  _buildRowItem('NIK', tenant.nik),
                  _buildRowItem('Tempat Lahir', tenant.placeOfBirth ?? '-'),
                  _buildRowItem('Tanggal Lahir', tenant.dateOfBirth ?? '-'),
                  _buildRowItem('Alamat Asal', tenant.originAddress,
                      isMultiLine: true),
                ]),

            const Gap(20),

            _buildInfoCard(
                title: 'Kontak Darurat',
                icon: Icons.contact_phone_outlined,
                children: [
                  _buildRowItem('Nama Kerabat', ecName),
                  _buildRowItem('Nomor HP', ecPhone),
                ]),

            const Gap(20),

            _buildInfoCard(
                title: 'Status Hunian',
                icon: Icons.bedroom_parent_outlined,
                children: [
                  _buildRowItem('Kamar', roomInfo), // TODO: Fetch room number
                  _buildRowItem('Mulai Sewa', entryDate),
                ]),
            const Gap(20),

            _buildInfoCard(
                title: 'Status Pembayaran',
                icon: Icons.payments_outlined,
                children: [
                  _buildPaymentStatusRow(context, tenant.nextDueDate),
                ]),

            const Gap(30),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStatusRow(BuildContext context, String? nextDueDateIso) {
    if (nextDueDateIso == null) {
      return _buildRowItem('Status', 'Belum Ada Data');
    }

    final nextDueDate = DateTime.parse(nextDueDateIso);
    final today = DateTime.now();
    // Strip time for fair comparison
    final todayDate = DateTime(today.year, today.month, today.day);
    final dueDate =
        DateTime(nextDueDate.year, nextDueDate.month, nextDueDate.day);

    // Logic:
    // 1. Overdue: Today > DueDate
    // 2. Warning: 0 <= DueDate - Today <= 7 days
    // 3. Safe: Otherwise

    final difference = dueDate.difference(todayDate).inDays;

    String statusText;
    Color statusColor;
    Color bgColor;
    String? message;

    if (todayDate.isAfter(dueDate)) {
      // Overdue
      statusText = 'Belum Bayar';
      statusColor = Colors.red;
      bgColor = Colors.red.withOpacity(0.1);
      final overdueDays = todayDate.difference(dueDate).inDays;
      message = 'Pembayaran terlambat $overdueDays hari.';
    } else if (difference <= 7 && difference >= 0) {
      // Warning
      statusText = 'Hampir Tempo';
      statusColor = Colors.orange[800]!;
      bgColor = Colors.orange.withOpacity(0.1);
      if (difference == 0) {
        message = 'Jatuh tempo hari ini!';
      } else {
        message = 'Jatuh tempo dalam $difference hari lagi.';
      }
    } else {
      // Safe
      statusText = 'Lunas / Aman';
      statusColor = Colors.green;
      bgColor = Colors.green.withOpacity(0.1);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Status',
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                statusText,
                style: GoogleFonts.poppins(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const Gap(12),
        _buildRowItem('Jatuh Tempo',
            DateFormat('dd MMMM yyyy', 'id_ID').format(nextDueDate)),
        if (message != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: statusColor,
                  fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // ... existing code ...

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const Gap(8),
          Text(label,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 13))
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1877F2), size: 20),
              const Gap(12),
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87))
            ],
          ),
          const Gap(20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRowItem(String label, String value, {bool isMultiLine = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value,
                textAlign: isMultiLine ? TextAlign.left : TextAlign.right,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.4)),
          )
        ],
      ),
    );
  }
}
