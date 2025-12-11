import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancialSummaryCard extends StatelessWidget {
  final double income;
  final double expense;
  final double netProfit;

  const FinancialSummaryCard({
    super.key,
    required this.income,
    required this.expense,
    required this.netProfit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Keuangan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Bulan Ini',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.7),
            ),
          ),
          const Gap(20),
          _FinancialItem(
            label: 'Pendapatan',
            amount: income,
            color: const Color(0xFF4CAF50),
            backgroundColor: const Color(0xFFE8F5E9),
            icon: Icons.trending_up,
            percentage: '+12%',
          ),
          const Gap(16),
          _FinancialItem(
            label: 'Pengeluaran',
            amount: expense,
            color: const Color(0xFFF44336),
            backgroundColor: const Color(0xFFFFEBEE),
            icon: Icons.trending_down,
            percentage: '+5%',
          ),
          const Gap(16),
          _FinancialItem(
            label: 'Laba Bersih',
            amount: netProfit,
            color: const Color(0xFF1877F2),
            backgroundColor: const Color(0xFFE3F2FD),
            icon: Icons.attach_money,
            percentage: '30% Margin',
            isPercentageBadge: true,
          ),
        ],
      ),
    );
  }
}

class _FinancialItem extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final Color backgroundColor;
  final IconData icon;
  final String percentage;
  final bool isPercentageBadge;

  const _FinancialItem({
    required this.label,
    required this.amount,
    required this.color,
    required this.backgroundColor,
    required this.icon,
    required this.percentage,
    this.isPercentageBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final formattedAmount =
        'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

    // For item background, we want it to adapt or stay light?
    // The passed backgroundColor (e.g., E8F5E9) is very light green. In Dark mode this might look too bright.
    // Ideally we blend it with surface color or reduce opacity.

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? color.withOpacity(0.1) // Dark mode: use low opacity of main color
            : backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? color.withOpacity(0.2)
                : backgroundColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  formattedAmount,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPercentageBadge ? color : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              percentage,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isPercentageBadge ? Colors.white : color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
