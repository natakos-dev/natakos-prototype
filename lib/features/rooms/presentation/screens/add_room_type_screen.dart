import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/room_provider.dart';
import '../../data/models/room_type_model.dart';

class AddRoomTypeScreen extends ConsumerStatefulWidget {
  final RoomTypeModel? initialData;
  const AddRoomTypeScreen({super.key, this.initialData});

  @override
  ConsumerState<AddRoomTypeScreen> createState() => _AddRoomTypeScreenState();
}

class _AddRoomTypeScreenState extends ConsumerState<AddRoomTypeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  bool _isLoading = false;

  String _paymentScheme = 'Bulanan';
  final List<String> _schemeOptions = ['Bulanan', 'Mingguan', 'Tahunan'];

  final Map<String, bool> _facilities = {
    'AC': false,
    'Kamar Mandi Dalam': false,
    'Air Panas': false,
    'WiFi': false,
    'Kasur': false,
    'Lemari': false,
    'Meja Belajar': false,
  };

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData?.name);
    _priceController = TextEditingController(
        text: widget.initialData?.monthlyPrice.toStringAsFixed(0));

    if (widget.initialData != null) {
      _paymentScheme = widget.initialData!.paymentScheme;
      for (var f in widget.initialData!.facilities) {
        if (_facilities.containsKey(f)) {
          _facilities[f] = true;
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final selectedFacilities = _facilities.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      final roomType = RoomTypeModel(
        id: widget.initialData?.id ?? '', // Use existing ID if editing
        name: _nameController.text,
        monthlyPrice: double.parse(_priceController.text.replaceAll('.', '')),
        paymentScheme: _paymentScheme,
        facilities: selectedFacilities,
      );

      // Perform the action
      if (widget.initialData != null) {
        await ref
            .read(roomControllerProvider.notifier)
            .updateRoomType(roomType);
      } else {
        await ref.read(roomControllerProvider.notifier).addRoomType(roomType);
      }

      // Check state after await
      if (mounted) {
        final state = ref.read(roomControllerProvider);

        if (state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        } else {
          // Success
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(widget.initialData != null
                    ? 'Tipe kamar berhasil diupdate'
                    : 'Tipe kamar berhasil ditambahkan')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected Error: $e')),
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
        title: Text(
          widget.initialData != null ? 'Edit Tipe Kamar' : 'Tambah Tipe Kamar',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Informasi Dasar'),
              const Gap(16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Tipe',
                  hintText: 'Contoh: Deluxe, Standard',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const Gap(16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const Gap(16),
              DropdownButtonFormField<String>(
                value: _paymentScheme,
                decoration: InputDecoration(
                  labelText: 'Skema Pembayaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _schemeOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _paymentScheme = newValue!;
                  });
                },
              ),
              const Gap(24),
              _buildSectionTitle('Fasilitas'),
              const Gap(8),
              ..._facilities.keys.map((key) {
                return CheckboxListTile(
                  title: Text(key, style: GoogleFonts.poppins()),
                  value: _facilities[key],
                  onChanged: (bool? value) {
                    setState(() {
                      _facilities[key] = value ?? false;
                    });
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: const Color(0xFF1877F2),
                );
              }),
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
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.initialData != null
                              ? 'Simpan Perubahan'
                              : 'Simpan Tipe Kamar',
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1877F2),
      ),
    );
  }
}
