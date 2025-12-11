import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/room_dummy.dart';
import '../providers/room_provider.dart';

class RoomsTab extends ConsumerStatefulWidget {
  const RoomsTab({super.key});

  @override
  ConsumerState<RoomsTab> createState() => _RoomsTabState();
}

class _RoomsTabState extends ConsumerState<RoomsTab> {
  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final roomsAsync = ref.watch(roomListProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-room'),
        backgroundColor: const Color(0xFF1877F2),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Kamar',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: roomsAsync.when(
        data: (rooms) {
          List<Room> filteredRooms = rooms.where((room) {
            if (_selectedFilter == 'Semua') return true;
            if (_selectedFilter == 'Terisi') return room.status == 'Terisi';
            if (_selectedFilter == 'Kosong') return room.status == 'Kosong';
            return true;
          }).toList();

          int totalRooms = rooms.length;
          int occupiedRooms = rooms.where((r) => r.status == 'Terisi').length;
          int emptyRooms = rooms.where((r) => r.status == 'Kosong').length;

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manajemen Kamar',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            'Kelola ketersediaan kamar dan harga',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => context.push('/room-types'),
                        icon: const Icon(Icons.playlist_add_check,
                            color: Color(0xFF1877F2), size: 28),
                        tooltip: 'Kelola Tipe Kamar',
                      ),
                    ],
                  ),
                ),
              ),

              const SliverGap(24),

              // Summary Stats
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                            'Total Kamar', '$totalRooms', Colors.blue,
                            isActive: _selectedFilter == 'Semua',
                            onTap: () =>
                                setState(() => _selectedFilter = 'Semua')),
                      ),
                      const Gap(12),
                      Expanded(
                        child: _buildSummaryItem(
                            'Kamar Terisi', '$occupiedRooms', Colors.orange,
                            isActive: _selectedFilter == 'Terisi',
                            onTap: () =>
                                setState(() => _selectedFilter = 'Terisi')),
                      ),
                      const Gap(12),
                      Expanded(
                        child: _buildSummaryItem(
                            'Kamar Kosong', '$emptyRooms', Colors.green,
                            isActive: _selectedFilter == 'Kosong',
                            onTap: () =>
                                setState(() => _selectedFilter = 'Kosong')),
                      ),
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
                      final room = filteredRooms[index];
                      return _buildRoomCard(room, isDark);
                    },
                    childCount: filteredRooms.length,
                  ),
                ),
              ),

              const SliverGap(80),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
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
          border: isActive
              ? null
              : Border.all(
                  color:
                      Colors.grey.withOpacity(0.1)), // Add border for inactive
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 28, // Larger number
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

  Widget _buildRoomCard(Room room, bool isDark) {
    bool isOccupied = room.status == 'Terisi';
    Color statusColor = isOccupied ? Colors.orange : Colors.green;

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  room.roomNumber,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.type,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    isOccupied ? room.tenantName! : 'Belum ada penghuni',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isOccupied
                          ? (isDark ? Colors.white : Colors.black87)
                          : Colors.grey[400],
                    ),
                  ),
                  const Gap(6),
                  Text(
                    room.price,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF1877F2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                room.status,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
