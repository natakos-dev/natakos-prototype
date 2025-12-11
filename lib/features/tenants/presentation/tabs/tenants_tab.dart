import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/tenant_model.dart';
import '../providers/tenant_provider.dart';

class TenantsTab extends ConsumerStatefulWidget {
  const TenantsTab({super.key});

  @override
  ConsumerState<TenantsTab> createState() => _TenantsTabState();
}

class _TenantsTabState extends ConsumerState<TenantsTab> {
  String _searchQuery = '';
  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final tenantsAsync = ref.watch(tenantListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-tenant'),
        backgroundColor: const Color(0xFF1877F2),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Penghuni',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: tenantsAsync.when(
        data: (tenants) {
          // Filter logic
          List<TenantModel> filteredTenants = tenants.where((t) {
            final matchesSearch =
                t.fullName.toLowerCase().contains(_searchQuery.toLowerCase());
            // TODO: check status logic.
            // TenantModel currently doesn't have explicit 'status'.
            // We can assume 'Aktif' for now if they are in the list.
            // Or we check Contract status if we want to be fancy.
            // For now, let's just assume all are 'Aktif' for simplicity
            // OR checks notes/other fields if we store status there.
            // The previous mock had: status 'Aktif' or 'Menunggu'.
            // I'll stick to 'Semua' filter mostly working, others might be placeholder.

            if (_selectedFilter == 'Semua') return matchesSearch;
            // if (_selectedFilter == 'Aktif') return t.status == 'Aktif' && matchesSearch;
            // if (_selectedFilter == 'Menunggu') return t.status == 'Menunggu' && matchesSearch;
            return matchesSearch;
          }).toList();

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manajemen Penghuni',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        'Kelola semua penyewa kos Anda',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Gap(24),
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDark ? const Color(0xFF2C2C2C) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (value) =>
                              setState(() => _searchQuery = value),
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Cari nama...',
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.grey[400], fontSize: 14),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.grey[400]),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                          ),
                        ),
                      ),
                      const Gap(24),
                    ],
                  ),
                ),
              ),

              // Summary Stats (Mocked or calculated)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                            'Total', '${tenants.length}', Colors.blue,
                            isActive: _selectedFilter == 'Semua',
                            onTap: () =>
                                setState(() => _selectedFilter = 'Semua')),
                      ),
                      const Gap(12),
                      Expanded(
                        child: _buildSummaryItem(
                            'Aktif', '${tenants.length}', Colors.green,
                            isActive: _selectedFilter == 'Aktif',
                            onTap: () =>
                                setState(() => _selectedFilter = 'Aktif')),
                      ),
                      /*
                      const Gap(12),
                      Expanded(
                        child: _buildSummaryItem('Menunggu', '0', Colors.orange,
                            isActive: _selectedFilter == 'Menunggu',
                            onTap: () =>
                                setState(() => _selectedFilter = 'Menunggu')),
                      ),
                      */
                    ],
                  ),
                ),
              ),

              const SliverGap(24),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tenant = filteredTenants[index];
                      return _buildTenantTile(context, tenant, isDark);
                    },
                    childCount: filteredTenants.length,
                  ),
                ),
              ),
              const SliverGap(80),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String count, MaterialColor color,
      {bool isActive = false, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive
              ? color
              : (isDark ? const Color(0xFF2C2C2C) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? color.withOpacity(0.4)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border:
              isActive ? null : Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isActive
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
            const Gap(4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color:
                    isActive ? Colors.white.withOpacity(0.9) : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenantTile(
      BuildContext context, TenantModel tenant, bool isDark) {
    // Determine status logic
    Color statusColor = Colors.grey;
    String statusLabel = '';

    if (tenant.nextDueDate != null) {
      final nextDueDate = DateTime.parse(tenant.nextDueDate!);
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final dueDate =
          DateTime(nextDueDate.year, nextDueDate.month, nextDueDate.day);

      final diff = dueDate.difference(todayDate).inDays;

      if (todayDate.isAfter(dueDate)) {
        statusColor = Colors.red;
        statusLabel = 'Telat Bayar';
      } else if (diff <= 7 && diff >= 0) {
        statusColor = Colors.orange;
        statusLabel = 'Hampir Tempo';
      } else {
        statusColor = Colors.green;
        statusLabel = 'Aman';
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            context.push('/tenant-detail', extra: tenant);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue[100],
                      child: Text(
                        tenant.fullName.isNotEmpty
                            ? tenant.fullName[0].toUpperCase()
                            : '?',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800]),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tenant.fullName,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey[500]),
                          const Gap(4),
                          Text(
                            tenant.phoneNumber,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const Gap(8),
                          if (statusLabel.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                statusLabel,
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: statusColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
