import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../providers/transaction_provider.dart';
import '../../data/models/transaction_model.dart';
import '../../../../core/theme/app_theme.dart';

class FinanceTab extends HookConsumerWidget {
  const FinanceTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State for selected month filter
    final selectedDate = useState(DateTime.now());

    // Keys for auto-scrolling to current month
    final itemKeys =
        useMemoized(() => List.generate(12, (index) => GlobalKey()));

    // Auto-scroll to current month on init
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentMonthIndex = DateTime.now().month - 1;
        final context = itemKeys[currentMonthIndex].currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            alignment: 0.5, // Center the item
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
      return null;
    }, []); // Empty keys = run once on mount

    final incomeAsync = ref.watch(totalIncomeProvider);
    final expenseAsync = ref.watch(totalExpenseProvider);
    final netIncomeAsync = ref.watch(netIncomeProvider);
    final transactionsAsync = ref.watch(transactionListProvider);

    // Filter transactions by selected month
    final filteredTransactions = transactionsAsync.valueOrNull?.where((t) {
          return t.date.year == selectedDate.value.year &&
              t.date.month == selectedDate.value.month;
        }).toList() ??
        [];

    // Sort transactions
    filteredTransactions.sort((a, b) => b.date.compareTo(a.date));

    // Group by Date
    final groupedTransactions =
        groupBy(filteredTransactions, (TransactionModel t) {
      return DateTime(t.date.year, t.date.month, t.date.day);
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Laporan Keuangan',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  Text(
                    'Ringkasan pendapatan dan pengeluaran',
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
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSummaryCard(
                    context,
                    title: 'Pendapatan Bersih',
                    value: netIncomeAsync.valueOrNull ?? 0,
                    icon: Icons.account_balance_wallet,
                    color: Colors.blue,
                    isMain: true,
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          context,
                          title: 'Pemasukan',
                          value: incomeAsync.valueOrNull ?? 0,
                          icon: Icons.attach_money,
                          color: Colors.green,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: _buildSummaryCard(
                          context,
                          title: 'Pengeluaran',
                          value: expenseAsync.valueOrNull ?? 0,
                          icon: Icons.money_off,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverGap(24),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Transaksi',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Export'),
                      ),
                    ],
                  ),
                  const Gap(8),
                  // Month Selector
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                        bottom:
                            8), // Padding specifically for scroll view content avoiding clip
                    child: Row(
                      children: List.generate(12, (index) {
                        final now = DateTime.now();
                        // Generate months for current year: Jan (1) to Dec (12)
                        // index 0 -> Jan, index 11 -> Dec
                        final monthDate = DateTime(now.year, index + 1);

                        final isSelected =
                            selectedDate.value.year == monthDate.year &&
                                selectedDate.value.month == monthDate.month;

                        return Padding(
                          key: itemKeys[index], // Assign Key Here
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => selectedDate.value = monthDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(20),
                                border: isSelected
                                    ? null
                                    : Border.all(
                                        color: Theme.of(context).dividerColor),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        )
                                      ]
                                    : null,
                              ),
                              child: Text(
                                DateFormat('MMMM', 'id_ID').format(monthDate),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(), // Order: Jan -> Dec
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverGap(16),
          if (transactionsAsync.isLoading)
            const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()))
          else if (filteredTransactions.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: Text('Tidak ada transaksi bulan ini')),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final dateKey = groupedTransactions.keys.elementAt(index);
                    final dayTransactions = groupedTransactions[dateKey]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            DateFormat('dd MMMM yyyy', 'id_ID').format(dateKey),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                          ),
                        ),
                        ...dayTransactions.map((transaction) {
                          final isIncome =
                              transaction.type == TransactionType.income;

                          // Restore "Card" Style with Theme support
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? (isIncome
                                            ? Colors.green.withOpacity(0.2)
                                            : Colors.red.withOpacity(0.2))
                                        : (isIncome
                                            ? Colors.green.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                      _getCategoryIcon(transaction.category),
                                      color:
                                          isIncome ? Colors.green : Colors.red,
                                      size: 24),
                                ),
                                const Gap(16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction.category,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color),
                                      ),
                                      if (transaction.relatedName != null)
                                        Text(
                                          transaction.relatedName!,
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color),
                                        ),
                                      if (transaction.description != null &&
                                          transaction.description!.isNotEmpty)
                                        Text(
                                          transaction.description!,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.color
                                                  ?.withOpacity(0.7)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${isIncome ? "+" : "-"} Rp ${NumberFormat('#,###', 'id_ID').format(transaction.amount)}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isIncome ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const Gap(8),
                      ],
                    );
                  },
                  childCount: groupedTransactions.keys.length,
                ),
              ),
            ),
          const SliverGap(80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-transaction'),
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Transaksi',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'listrik':
        return Icons.electric_bolt;
      case 'air':
        return Icons.water_drop;
      case 'internet/wifi':
        return Icons.wifi;
      case 'perbaikan':
        return Icons.build;
      case 'gaji pegawai':
        return Icons.people;
      case 'pembayaran sewa':
        return Icons.home;
      case 'makanan':
        return Icons.restaurant;
      case 'transportasi':
        return Icons.directions_car;
      default:
        return Icons.attach_money;
    }
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required double value,
    required IconData icon,
    required Color color,
    bool isMain = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isMain
            ? color
            : Theme.of(context).cardColor, // Use cardColor instead of white
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isMain
                ? color.withOpacity(0.2)
                : Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isMain
                      ? Colors.white.withOpacity(0.2)
                      : color.withOpacity(isDark ? 0.2 : 0.1),
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(icon, color: isMain ? Colors.white : color, size: 20),
              ),
              const Gap(12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: isMain
                      ? Colors.white
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            'Rp ${NumberFormat('#,###', 'id_ID').format(value)}',
            style: GoogleFonts.poppins(
              color: isMain
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: isMain ? 24 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
