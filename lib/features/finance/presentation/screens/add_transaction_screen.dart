import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/transaction_model.dart';
import '../../presentation/providers/transaction_provider.dart';
import '../../../tenants/presentation/providers/tenant_provider.dart';
import '../../../rooms/presentation/providers/room_provider.dart';

class AddTransactionScreen extends HookConsumerWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = useState<TransactionType>(TransactionType.income);
    final amountController = useTextEditingController();
    final date = useState<DateTime>(DateTime.now());
    final descriptionController = useTextEditingController();
    final categoryController =
        useTextEditingController(); // For simple categorization

    // Consumers
    final tenantsAsync = ref.watch(tenantListProvider);
    final roomsAsync = ref.watch(roomListProvider);

    // For specialized Income logic (e.g., Tenant selection)
    final selectedTenantId = useState<String?>(null);
    final paymentMethod = useState<String>('Tunai');

    // Expense Categories
    final expensesCategories = [
      'Listrik',
      'Air',
      'Internet/Wifi',
      'Perbaikan',
      'Gaji Pegawai',
      'Lainnya',
    ];
    final selectedExpenseCategory = useState<String>(expensesCategories.first);

    // Income Source
    final incomeSource = useState<String>('Kontrak'); // 'Kontrak' or 'Lainnya'

    // Logic to update amount when tenant is selected
    void onTenantSelected(String? tenantId) {
      selectedTenantId.value = tenantId;
      if (tenantId == null) return;

      tenantsAsync.whenData((tenants) {
        final tenant = tenants.firstWhere((t) => t.id == tenantId);

        // Find room for this tenant
        roomsAsync.whenData((rooms) {
          // Match by tenant name as established in RoomModel logic
          // Or strictly, we should have used IDs, but current app uses name linking in some parts
          // We'll try to match exact name first.
          try {
            final room =
                rooms.firstWhere((r) => r.tenantName == tenant.fullName);
            // Parse price: "Rp 1.500.000" -> 1500000
            final priceString = room.price.replaceAll(RegExp(r'[^0-9]'), '');
            if (priceString.isNotEmpty) {
              amountController.text = priceString;
              // Add simple formatting if needed, but raw number is safer for controller
              final number = double.tryParse(priceString);
              if (number != null) {
                amountController.text =
                    NumberFormat('#,###', 'id_ID').format(number);
              }
            }

            if (descriptionController.text.isEmpty) {
              // Description left empty as per user request (optional)
            }
          } catch (e) {
            // No room found for this tenant, ignore
          }
        });
      });
    }

    Future<void> _submit() async {
      String rawAmount =
          amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (rawAmount.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon isi jumlah transaksi')),
        );
        return;
      }

      final amount = double.tryParse(rawAmount) ?? 0;
      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jumlah harus lebih dari 0')),
        );
        return;
      }

      final category = type.value == TransactionType.income
          ? (incomeSource.value == 'Kontrak'
              ? 'Pembayaran Sewa'
              : categoryController.text)
          : (selectedExpenseCategory.value == 'Lainnya'
              ? categoryController.text
              : selectedExpenseCategory.value);

      if (category.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon isi kategori')),
        );
        return;
      }

      // If Contract Income, require Tenant
      if (type.value == TransactionType.income &&
          incomeSource.value == 'Kontrak' &&
          selectedTenantId.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon pilih penghuni')),
        );
        return;
      }

      String? relatedName;
      if (selectedTenantId.value != null) {
        tenantsAsync.whenData((tenants) {
          try {
            final t = tenants.firstWhere((t) => t.id == selectedTenantId.value);
            relatedName = t.fullName;
          } catch (_) {}
        });
      }

      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type.value,
        amount: amount,
        date: date.value,
        category: category,
        description: descriptionController.text,
        paymentMethod: paymentMethod.value,
        relatedId: selectedTenantId.value,
        relatedName: relatedName,
      );

      try {
        await ref
            .read(transactionControllerProvider.notifier)
            .addTransaction(transaction);

        // Auto-update Tenant Due Date if "Pembayaran Sewa"
        if (type.value == TransactionType.income &&
            category == 'Pembayaran Sewa' &&
            selectedTenantId.value != null) {
          final tenantId = selectedTenantId.value!;

          // We need to fetch the tenant fresh or from the list we have
          final tenants = ref.read(tenantListProvider).valueOrNull;
          if (tenants != null) {
            final tenant = tenants.firstWhere((t) => t.id == tenantId);

            // Calculate new due date
            DateTime currentDueDate;
            if (tenant.nextDueDate != null) {
              currentDueDate =
                  DateTime.tryParse(tenant.nextDueDate!) ?? DateTime.now();
            } else {
              currentDueDate = DateTime.now();
            }

            // Add 1 month
            final newDueDate = DateTime(
              currentDueDate.year,
              currentDueDate.month + 1,
              currentDueDate.day,
            );

            final newDueDateIso = DateFormat('yyyy-MM-dd').format(newDueDate);

            final updatedTenant = tenant.copyWith(
              nextDueDate: newDueDateIso,
            );

            await ref
                .read(tenantControllerProvider.notifier)
                .updateTenant(updatedTenant);
          }
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaksi berhasil disimpan')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan: $e')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Transaksi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. Transaction Type
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => type.value = TransactionType.income,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: type.value == TransactionType.income
                              ? AppTheme.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Pemasukan',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: type.value == TransactionType.income
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => type.value = TransactionType.expense,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: type.value == TransactionType.expense
                              ? Colors.red
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Pengeluaran',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: type.value == TransactionType.expense
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),

            // 2. Date
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: date.value,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) date.value = picked;
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 20, color: Colors.grey),
                    const Gap(12),
                    Text(
                      DateFormat('dd MMMM yyyy', 'id_ID').format(date.value),
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),

            // 3. Conditional Fields
            if (type.value == TransactionType.income) ...[
              Text('Sumber Pemasukan',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Radio<String>(
                    value: 'Kontrak',
                    groupValue: incomeSource.value,
                    onChanged: (val) => incomeSource.value = val!,
                  ),
                  const Text('Sewa Kos'),
                  Radio<String>(
                    value: 'Lainnya',
                    groupValue: incomeSource.value,
                    onChanged: (val) => incomeSource.value = val!,
                  ),
                  const Text('Lain-lain'),
                ],
              ),
              if (incomeSource.value == 'Kontrak') ...[
                const Gap(12),
                tenantsAsync.when(
                  data: (tenants) {
                    final activeTenants =
                        tenants; // Assuming all returned are active for now
                    if (activeTenants.isEmpty) {
                      return const Text('Belum ada penghuni.');
                    }
                    return DropdownButtonFormField<String>(
                      value: selectedTenantId.value,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Penghuni',
                        border: OutlineInputBorder(),
                      ),
                      items: activeTenants.map((t) {
                        return DropdownMenuItem(
                          value: t.id,
                          child: Text(t.fullName),
                        );
                      }).toList(),
                      onChanged: onTenantSelected,
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, s) => Text('Error loading tenants: $e'),
                ),
              ],
              if (incomeSource.value == 'Lainnya')
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Kategori / Sumber',
                    border: OutlineInputBorder(),
                  ),
                ),
            ] else ...[
              Text('Kategori Pengeluaran',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const Gap(8),
              DropdownButtonFormField<String>(
                value: selectedExpenseCategory.value,
                items: expensesCategories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => selectedExpenseCategory.value = val!,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              if (selectedExpenseCategory.value == 'Lainnya') ...[
                const Gap(12),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Tulis Kategori',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ],
            const Gap(24),

            // 4. Amount
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah (Rp)',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(24),

            // 5. Payment Method & Notes
            DropdownButtonFormField<String>(
              value: paymentMethod.value,
              items: ['Tunai', 'Transfer', 'QRIS']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => paymentMethod.value = val!,
              decoration: const InputDecoration(
                labelText: 'Metode Pembayaran',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Catatan (Opsional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const Gap(32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: type.value == TransactionType.income
                      ? AppTheme.primaryColor
                      : Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Simpan Transaksi',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
