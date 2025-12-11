import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../providers/user_profile_provider.dart';
import '../providers/theme_provider.dart';
import '../../../../core/utils/dummy_data_generator.dart';
import '../../data/repositories/settings_repository_impl.dart';

class SettingsTab extends ConsumerWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final themeMode = ref.watch(themeModeProvider);

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
                  // Profile Header if loaded
                  profileAsync.when(
                    data: (profile) => Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            profile?.name.isNotEmpty == true
                                ? profile!.name[0].toUpperCase()
                                : 'U',
                            style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Gap(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.name ?? 'User',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                            Text(
                              profile?.kosName ?? 'Nama Kos Belum Diatur',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    loading: () => const Text('Loading profile...'),
                    error: (_, __) => const Text('Error loading profile'),
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader(context, 'Umum'),
                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.dark_mode_outlined,
                  title: 'Tema Gelap',
                  subtitle: themeMode == ThemeMode.dark ? 'Aktif' : 'Non-aktif',
                  onTap: () {},
                  trailing: Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (val) {
                        ref.read(themeModeProvider.notifier).toggleTheme(val);
                      }),
                ),
                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifikasi',
                  subtitle: 'Aktif',
                  onTap: () {},
                  trailing: Switch(value: true, onChanged: (val) {}),
                ),
                const Gap(24),

                // Variabel Kos - Real Data
                _buildSectionHeader(context, 'Variabel Kos'),
                const Gap(12),
                profileAsync.when(
                  data: (profile) {
                    return Column(
                      children: [
                        _buildSettingItem(
                          context,
                          icon: Icons.home_work_outlined,
                          title: 'Nama Kos',
                          subtitle: profile?.kosName ?? '-',
                          onTap: () {
                            if (profile != null) {
                              _showEditDialog(
                                context,
                                ref,
                                'Nama Kos',
                                profile.kosName,
                                (val) {
                                  ref
                                      .read(settingsRepositoryProvider)
                                      .updateUserProfile(
                                          profile.copyWith(kosName: val));
                                },
                              );
                            }
                          },
                        ),
                        const Gap(12),
                        _buildSettingItem(
                          context,
                          icon: Icons.location_on_outlined,
                          title: 'Alamat',
                          subtitle: profile?.kosAddress ?? '-',
                          onTap: () {
                            if (profile != null) {
                              _showEditDialog(
                                context,
                                ref,
                                'Alamat',
                                profile.kosAddress,
                                (val) {
                                  ref
                                      .read(settingsRepositoryProvider)
                                      .updateUserProfile(
                                          profile.copyWith(kosAddress: val));
                                },
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.calendar_month_outlined,
                  title: 'Tanggal Jatuh Tempo',
                  subtitle: 'Tanggal 5 setiap bulan',
                  onTap: () {
                    // Logic date picker later
                  },
                ),
                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.money_off_outlined,
                  title: 'Denda Keterlambatan',
                  subtitle: 'Rp 50.000 / hari',
                  onTap: () {
                    // Logic update denda
                  },
                ),
                const Gap(24),
                _buildSectionHeader(context, 'Akun'),
                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Edit Nama Pemilik',
                  subtitle: 'Ubah nama pemilik kos',
                  onTap: () => profileAsync.whenData((profile) {
                    if (profile != null) {
                      _showEditDialog(
                        context,
                        ref,
                        'Nama Pemilik',
                        profile.name,
                        (val) {
                          ref
                              .read(settingsRepositoryProvider)
                              .updateUserProfile(profile.copyWith(name: val));
                        },
                      );
                    }
                  }),
                ),
                const Gap(24),
                _buildSectionHeader(context, 'Developer Area'),
                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.data_array,
                  title: 'Generate Data Simulasi',
                  subtitle: 'Isi data dummy untuk presentasi',
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text('Generate Dummy Data?'),
                        content: const Text(
                            'Ini akan menambahkan data tipe kamar, kamar, penghuni, dan transaksi. Pastikan data tidak duplikat.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(c, false),
                              child: const Text('Batal')),
                          TextButton(
                              onPressed: () => Navigator.pop(c, true),
                              child: const Text('Generate')),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      try {
                        await DummyDataGenerator.generate(ref);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Data simulasi berhasil ditambahkan!')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal: $e')),
                          );
                        }
                      }
                    }
                  },
                ),
                const Gap(12),
                _buildSettingItem(
                  context,
                  icon: Icons.logout,
                  title: 'Keluar',
                  subtitle: 'Keluar dari aplikasi',
                  isDestructive: true,
                  onTap: () {
                    ref.read(authControllerProvider.notifier).logout();
                  },
                ),
                const Gap(40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1877F2),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
    bool isDestructive = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? Colors.red.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive ? Colors.red : Colors.blue,
                    size: 20,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDestructive
                              ? Colors.red
                              : (isDark ? Colors.white : Colors.black87),
                        ),
                      ),
                      const Gap(2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null)
                  trailing
                else
                  Icon(Icons.chevron_right, color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, String title,
      String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title', style: GoogleFonts.poppins()),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSave(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
