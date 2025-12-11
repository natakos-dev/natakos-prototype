import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/room_provider.dart';
import '../../data/models/room_model.dart';

class AddRoomScreen extends ConsumerStatefulWidget {
  const AddRoomScreen({super.key});

  @override
  ConsumerState<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends ConsumerState<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _roomNumberController = TextEditingController();
  final _countController = TextEditingController(text: '1');

  bool _isBatchMode = false;
  String? _selectedTypeId;
  bool _isRoomNumberLocked = false; // Add locked state

  @override
  void dispose() {
    _roomNumberController.dispose();
    _countController.dispose();
    super.dispose();
  }

  // Update logic to be type-aware
  void _updateRoomNumberLogic(List<RoomModel> allRooms, String? typeId) {
    if (typeId == null) return;

    // Filter rooms by selected type
    final typeRooms = allRooms.where((r) => r.roomTypeId == typeId).toList();

    if (typeRooms.isNotEmpty) {
      // If rooms exist for this type, enforce auto-increment
      int maxNumber = 0;
      for (var room in typeRooms) {
        final num = int.tryParse(room.roomNumber);
        if (num != null && num > maxNumber) {
          maxNumber = num;
        }
      }
      _roomNumberController.text = (maxNumber + 1).toString();
      setState(() {
        _isRoomNumberLocked = true; // Lock the field
      });
    } else {
      // If no rooms exist, allow manual input
      if (_roomNumberController.text.isEmpty) {
        // Optional: Maybe suggest something based on floor or just leave empty
      }
      setState(() {
        _isRoomNumberLocked = false; // Unlock the field
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedTypeId != null) {
      final startNumber = int.tryParse(_roomNumberController.text);
      if (startNumber == null) return;

      final count =
          _isBatchMode ? (int.tryParse(_countController.text) ?? 1) : 1;

      for (int i = 0; i < count; i++) {
        final currentNumber = startNumber + i;
        final newRoom = RoomModel(
          id: '',
          roomNumber: currentNumber.toString(),
          floor: 1, // Default to 1 for now
          isActive: true,
          roomTypeId: _selectedTypeId!,
          status: 'Kosong',
        );
        ref.read(roomControllerProvider.notifier).addRoom(newRoom);
      }

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomTypesAsync = ref.watch(roomTypeListProvider);
    final roomsAsync = ref.watch(rawRoomListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tambah Kamar',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            onPressed: () => context.push('/add-room-type'),
            icon: const Icon(Icons.playlist_add),
            tooltip: 'Tambah Tipe Kamar',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Kamar',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(20),

              // Room Type Dropdown (Moved UP to drive logic)
              roomTypesAsync.when(
                data: (roomTypes) => DropdownButtonFormField<String>(
                  value: _selectedTypeId,
                  decoration: InputDecoration(
                    labelText: 'Tipe Kamar',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: roomTypes.map((type) {
                    return DropdownMenuItem(
                      value: type.id,
                      child: Text('${type.name} (Rp ${type.monthlyPrice})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTypeId = value;
                    });
                    // Trigger Update Logic
                    if (roomsAsync.hasValue) {
                      _updateRoomNumberLogic(roomsAsync.value!, value);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih tipe kamar';
                    }
                    return null;
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (e, s) => Text('Error loading types: $e'),
              ),
              const Gap(16),

              // Batch Mode Toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Buat Banyak Kamar Sekaligus',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Buat beberapa kamar dengan nomor urut otomatis',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
                value: _isBatchMode,
                activeColor: const Color(0xFF1877F2),
                onChanged: (val) {
                  setState(() {
                    _isBatchMode = val;
                  });
                },
              ),
              const Gap(16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _roomNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      readOnly: _isRoomNumberLocked, // Validate Lock
                      enabled: !_isRoomNumberLocked, // Visually disable
                      decoration: InputDecoration(
                        labelText:
                            _isBatchMode ? 'Mulai dari Nomor' : 'Nomor Kamar',
                        hintText: 'Contoh: 101',
                        filled: _isRoomNumberLocked, // Gray out if locked
                        fillColor:
                            _isRoomNumberLocked ? Colors.grey[200] : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: _isRoomNumberLocked
                            ? const Icon(Icons.lock,
                                size: 20, color: Colors.grey)
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harus diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (_isBatchMode) ...[
                    const Gap(16),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _countController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: 'Jumlah',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.parse(value) < 1) {
                            return 'Min 1';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ],
              ),

              if (_isBatchMode)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Builder(
                    builder: (context) {
                      final start =
                          int.tryParse(_roomNumberController.text) ?? 0;
                      final count = int.tryParse(_countController.text) ?? 0;
                      if (start > 0 && count > 0) {
                        final end = start + count - 1;
                        return Text(
                          'Akan membuat kamar: $start - $end',
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: Colors.blue),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),

              if (_isRoomNumberLocked)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Nomor kamar otomatis diurutkan berdasarkan kamar terakhir di tipe ini.',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic),
                  ),
                ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => context.push('/add-room-type'),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Buat Tipe Baru'),
                ),
              ),

              const Gap(40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1877F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isBatchMode ? 'Simpan Semua Kamar' : 'Simpan Kamar',
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
}
