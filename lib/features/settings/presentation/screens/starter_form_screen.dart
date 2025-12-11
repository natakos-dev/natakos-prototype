import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/user_profile_model.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class StarterFormScreen extends ConsumerStatefulWidget {
  const StarterFormScreen({super.key});

  @override
  ConsumerState<StarterFormScreen> createState() => _StarterFormScreenState();
}

class _StarterFormScreenState extends ConsumerState<StarterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _kosNameController = TextEditingController();
  final _kosAddressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _kosNameController.dispose();
    _kosAddressController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User ID not found');
      }

      final profile = UserProfileModel(
        uid: userId,
        name: _nameController.text,
        kosName: _kosNameController.text,
        kosAddress: _kosAddressController.text,
        themeMode: 'light',
        isDataComplete: true,
      );

      await ref.read(settingsRepositoryProvider).updateUserProfile(profile);

      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Selamat Datang di NataKos!',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lengkapi Data Awal',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1877F2),
                ),
              ),
              const Gap(8),
              Text(
                'Data ini akan digunakan untuk identitas kos anda.',
                style: GoogleFonts.poppins(color: Colors.grey[600]),
              ),
              const Gap(32),
              _buildTextField(
                label: 'Nama Pemilik',
                controller: _nameController,
                icon: Icons.person_outline,
              ),
              const Gap(20),
              _buildTextField(
                label: 'Nama Kos',
                controller: _kosNameController,
                icon: Icons.home_work_outlined,
                hint: 'Contoh: Kos Bahagia',
              ),
              const Gap(20),
              _buildTextField(
                label: 'Alamat Kos',
                controller: _kosAddressController,
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),
              const Gap(40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1877F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text(
                          'Simpan & Lanjut',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        isDense: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
