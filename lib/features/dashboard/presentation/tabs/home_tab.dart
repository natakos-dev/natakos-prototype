import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/financial_summary_card.dart';
import '../widgets/summary_card.dart';
import '../controllers/dashboard_controller.dart';
import '../../../rooms/presentation/providers/room_provider.dart';
import '../../../tenants/presentation/providers/tenant_provider.dart';
import '../../../finance/presentation/providers/transaction_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Real Data Providers
    final roomsAsync = ref.watch(roomListProvider);
    final tenantsAsync = ref.watch(tenantListProvider);
    final totalIncomeAsync = ref.watch(totalIncomeProvider);
    final totalExpenseAsync = ref.watch(totalExpenseProvider);

    // Derived State
    final int occupiedRooms =
        roomsAsync.valueOrNull?.where((r) => r.status == 'Terisi').length ?? 0;
    final int totalRooms = roomsAsync.valueOrNull?.length ?? 0;
    final int emptyRooms =
        roomsAsync.valueOrNull?.where((r) => r.status == 'Kosong').length ?? 0;
    final double occupancyPercentage =
        totalRooms > 0 ? (occupiedRooms / totalRooms) * 100 : 0;

    // Using filtered tenant list or total list as active contracts proxy
    // Assuming all tenants in the list are active
    final int activeContracts = tenantsAsync.valueOrNull?.length ?? 0;

    // Bills feature not implemented yet
    const int unpaidBills = 0;

    final double monthlyIncome = totalIncomeAsync.valueOrNull ?? 0;
    final double monthlyExpense = totalExpenseAsync.valueOrNull ?? 0;
    final double netProfit = monthlyIncome - monthlyExpense;

    void navigateToTab(int index) {
      ref.read(dashboardIndexProvider.notifier).state = index;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, Pemilik Kos! 👋',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          Text(
            'Simak perkembangan bisnis Anda hari ini.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.7),
            ),
          ),
          const Gap(24),

          // 2x2 Grid for Summary Cards
          LayoutBuilder(builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - 20) / 2;
            const cardHeight = 160.0; // Fixed height for consistency

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: SummaryCard(
                    title: 'Kamar Terisi',
                    value: '$occupiedRooms/$totalRooms',
                    subtitle:
                        '${occupancyPercentage.toStringAsFixed(0)}% kamar terisi',
                    icon: Icons.bedroom_parent,
                    backgroundColor: const Color(0xFF2196F3), // Blue
                    onTap: () => navigateToTab(1), // Rooms Tab
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: SummaryCard(
                    title: 'Kamar Kosong',
                    value: '$emptyRooms',
                    subtitle: 'Siap dihuni',
                    icon: Icons.meeting_room_outlined,
                    backgroundColor: const Color(0xFF4CAF50), // Green
                    onTap: () => navigateToTab(1), // Rooms Tab
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: SummaryCard(
                    title: 'Tagihan Menunggu',
                    value: '$unpaidBills',
                    subtitle: '(Under Development)', // Updated subtitle
                    icon: Icons.receipt_long,
                    backgroundColor: const Color(0xFFFF9800), // Orange
                    onTap: () =>
                        navigateToTab(3), // Finance Tab (Assumed index 3)
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: SummaryCard(
                    title: 'Total Penghuni', // Changed title to reflect data
                    value: '$activeContracts',
                    subtitle: 'Orang',
                    icon: Icons.people, // Changed icon
                    backgroundColor: const Color(0xFF9C27B0), // Purple
                    onTap: () => navigateToTab(2), // Tenants Tab
                  ),
                ),
              ],
            );
          }),

          const Gap(32),

          GestureDetector(
            onTap: () => navigateToTab(3), // Finance Tab
            child: FinancialSummaryCard(
              income: monthlyIncome,
              expense: monthlyExpense,
              netProfit: netProfit,
            ),
          ),

          const Gap(80),
        ],
      ),
    );
  }
}
