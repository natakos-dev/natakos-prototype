import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../rooms/presentation/providers/room_provider.dart';
import '../../../../core/services/ocr_service.dart';
import '../../data/models/tenant_model.dart';
import '../providers/tenant_provider.dart';

class AddTenantScreen extends ConsumerStatefulWidget {
  const AddTenantScreen({super.key});

  @override
  ConsumerState<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends ConsumerState<AddTenantScreen> {
  int _currentStep = 0;
  final _picker = ImagePicker();
  XFile? _pickedFile;
  Uint8List? _imageBytes;
  bool _isOcrLoading = false;

  // Form Keys
  final _step1FormKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  final _pobController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();

  String? _selectedRoomId;
  String? _selectedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _pobController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _pickedFile = pickedFile;
          _imageBytes = bytes;
          _isOcrLoading = true;
        });

        // OCR Process
        final ocrService = OcrServiceFactory.create();
        final ktpData = await ocrService.extractData(pickedFile.path);

        if (ktpData != null) {
          setState(() {
            _isOcrLoading = false;
            if (ktpData.nama != null) _nameController.text = ktpData.nama!;
            if (ktpData.nik != null) _nikController.text = ktpData.nik!;
            if (ktpData.tempatLahir != null)
              _pobController.text = ktpData.tempatLahir!;
            if (ktpData.tanggalLahir != null)
              _dobController.text = ktpData.tanggalLahir!;
            if (ktpData.alamat != null)
              _addressController.text = ktpData.alamat!;
          });

          if (mounted) {
            final message = kIsWeb
                ? 'Info: Data terisi otomatis (Mode Simulasi)'
                : 'OCR Berhasil: Data terbaca dari KTP';

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.blue,
              ),
            );
            // Auto redirect to next step
            _nextStep();
          }
        } else {
          setState(() => _isOcrLoading = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Gagal membaca data KTP. Pastikan foto jelas.')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil gambar: $e')),
        );
      }
    }
  }

  void _nextStep() {
    if (_currentStep == 0) {
      // Step 0 (OCR) is now optional
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      if (_step1FormKey.currentState!.validate()) {
        setState(() => _currentStep = 2);
      }
    } else if (_currentStep == 2) {
      if (_selectedRoomId != null && _selectedDate != null) {
        _submit();
      } else {
        if (_selectedRoomId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pilih kamar terlebih dahulu')));
        } else if (_selectedDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pilih tanggal masuk')));
        }
      }
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      context.pop();
    }
  }

  Future<void> _submit() async {
    // Create TenantModel
    final emergencyContact =
        '${_emergencyNameController.text} (${_emergencyPhoneController.text})';

    // Parse Entry Date (dd MMM yyyy -> yyyy-MM-dd)
    final dateFormat = DateFormat('dd MMM yyyy');
    DateTime entryDateObj = DateTime.now(); // Default to now
    if (_selectedDate != null) {
      try {
        entryDateObj = dateFormat.parse(_selectedDate!);
      } catch (e) {
        // Fallback to now if parse fails
      }
    }

    // Calculate Next Due Date (Entry Date + 1 Month)
    // Simple logic: just add 30 days or using DateTime logic
    DateTime nextDueDateObj = DateTime(
      entryDateObj.year,
      entryDateObj.month + 1,
      entryDateObj.day,
    );

    // Format for storage (ISO 8601 YYYY-MM-DD)
    final isoFormat = DateFormat('yyyy-MM-dd');
    final entryDateIso = isoFormat.format(entryDateObj);
    final nextDueDateIso = isoFormat.format(nextDueDateObj);

    final newTenant = TenantModel(
      id: '', // Will be generated by repo
      fullName: _nameController.text,
      nik: _nikController.text,
      phoneNumber: _phoneController.text,
      originAddress: _addressController.text,
      placeOfBirth: _pobController.text,
      dateOfBirth: _dobController.text,
      emergencyContact: emergencyContact,
      notes: 'Kamar: $_selectedRoomId',
      entryDate: entryDateIso,
      nextDueDate: nextDueDateIso,
    );

    // Add Tenant
    await ref.read(tenantControllerProvider.notifier).addTenant(newTenant);

    // Update Room Status
    if (_selectedRoomId != null) {
      ref.read(roomControllerProvider.notifier).updateRoomStatus(
          _selectedRoomId!, 'Terisi',
          tenantName: _nameController.text);
    }

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tambah Penghuni',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: _prevStep,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildCurrentStep(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _buildStepCircle(0, 'KTP'),
          _buildStepLine(0),
          _buildStepCircle(1, 'Biodata'),
          _buildStepLine(1),
          _buildStepCircle(2, 'Kamar'),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    bool isActive = _currentStep >= step;
    bool isCompleted = _currentStep > step;
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1877F2) : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${step + 1}',
                    style: GoogleFonts.poppins(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isActive ? const Color(0xFF1877F2) : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget _buildStepLine(int step) {
    return Expanded(
      child: Container(
        height: 2,
        color: _currentStep > step ? const Color(0xFF1877F2) : Colors.grey[200],
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Ktp();
      case 1:
        return _buildStep2Biodata();
      case 2:
        return _buildStep3Room();
      default:
        return Container();
    }
  }

  Widget _buildStep1Ktp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Foto KTP',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'Foto KTP digunakan untuk pengisian data otomatis (OCR)',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
        ),
        const Gap(24),

        // Image Area
        GestureDetector(
          onTap: () => _pickImage(ImageSource.gallery),
          child: Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.5,
                  style: BorderStyle.solid),
            ),
            child: _pickedFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _imageBytes != null
                        ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                        : const Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_a_photo_outlined,
                          size: 48, color: Colors.grey),
                      const Gap(12),
                      Text(
                        'Tap untuk upload foto',
                        style: GoogleFonts.poppins(color: Colors.grey[600]),
                      ),
                    ],
                  ),
          ),
        ),
        const Gap(20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Ambil Foto'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Galeri'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        if (_isOcrLoading) ...[
          const Gap(24),
          const LinearProgressIndicator(),
          const Gap(8),
          Center(
              child: Text('Sedang membaca data KTP...',
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.grey[600]))),
        ]
      ],
    );
  }

  Widget _buildStep2Biodata() {
    return Form(
      key: _step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lengkapi Data Diri',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const Gap(20),
          _buildTextField(label: 'Nama Lengkap', controller: _nameController),
          const Gap(16),
          _buildTextField(
              label: 'NIK',
              controller: _nikController,
              keyboardType: TextInputType.number),
          const Gap(16),
          Row(
            children: [
              Expanded(
                  child: _buildTextField(
                      label: 'Tempat Lahir', controller: _pobController)),
              const Gap(12),
              Expanded(
                  child: _buildTextField(
                      label: 'Tanggal Lahir', controller: _dobController)),
            ],
          ),
          const Gap(16),
          _buildTextField(
              label: 'Alamat Asal',
              controller: _addressController,
              maxLines: 3),
          const Gap(16),
          _buildTextField(
              label: 'No. HP',
              controller: _phoneController,
              keyboardType: TextInputType.phone),
          const Gap(24),
          Text('Kontak Darurat',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const Gap(16),
          _buildTextField(
              label: 'Nama Kontak', controller: _emergencyNameController),
          const Gap(16),
          _buildTextField(
              label: 'No. HP Kontak',
              controller: _emergencyPhoneController,
              keyboardType: TextInputType.phone),
        ],
      ),
    );
  }

  Widget _buildStep3Room() {
    final roomsAsync = ref.watch(roomListProvider);
    return roomsAsync.when(
      data: (rooms) {
        // Filter 'Kosong' and deduplicate by ID just in case
        final emptyRooms = rooms
            .where((r) => r.status == 'Kosong')
            .fold<Map<String, dynamic>>({}, (map, room) {
              map[room.id] = room;
              return map;
            })
            .values
            .toList();

        // Explicitly build items
        final dropdownItems = emptyRooms.map((room) {
          return DropdownMenuItem<String>(
            value: room.id,
            child: Text('Kamar ${room.roomNumber} - ${room.price}'),
          );
        }).toList();

        // Check value validity against the BUILT items
        final isValid =
            dropdownItems.any((item) => item.value == _selectedRoomId);
        final dropdownValue = isValid ? _selectedRoomId : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih Kamar & Tanggal',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const Gap(20),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              decoration: InputDecoration(
                labelText: 'Pilih Kamar',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.bedroom_parent_outlined),
              ),
              items: dropdownItems,
              onChanged: (value) => setState(() => _selectedRoomId = value),
            ),
            const Gap(16),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = DateFormat('dd MMM yyyy').format(picked);
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Tanggal Masuk',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                ),
                child: Text(
                  _selectedDate ?? 'Pilih Tanggal',
                  style: GoogleFonts.poppins(
                      color: _selectedDate == null
                          ? Colors.grey[600]
                          : Colors.black87),
                ),
              ),
            ),
            const Gap(32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F5FF),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: const Color(0xFF1877F2).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF1877F2)),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'Pastikan semua data sudah benar sebelum menyimpan data penghuni.',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF1877F2),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: _currentStep == 0
            ? OutlinedButton(
                onPressed: _nextStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1877F2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Lewati',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1877F2),
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1877F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentStep == 2 ? 'Simpan Data' : 'Lanjut',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        isDense: true,
      ),
      validator: (value) {
        if (!isOptional && (value == null || value.isEmpty)) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
