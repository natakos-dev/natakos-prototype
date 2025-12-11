import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/room_dummy.dart';
import '../../data/models/room_model.dart';
import '../../data/models/room_type_model.dart';
import '../../data/repositories/room_repository_impl.dart';

// UI Entity Mapper (combining RoomModel and RoomTypeModel)
final roomListProvider = StreamProvider<List<Room>>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);

  return roomRepository.getRooms().asyncMap((rooms) async {
    final roomTypes =
        await ref.watch(roomRepositoryProvider).getRoomTypes().first;

    return rooms.map((roomModel) {
      final type =
          roomTypes.firstWhereOrNull((t) => t.id == roomModel.roomTypeId);

      return Room(
        id: roomModel.id,
        roomNumber: roomModel.roomNumber,
        status: roomModel.isActive
            ? (roomModel.currentTenantName != null ? 'Terisi' : 'Kosong')
            : 'Non-Aktif',
        tenantName: roomModel.currentTenantName,
        type: type?.name ?? 'Unknown',
        price: 'Rp ${type?.monthlyPrice.toStringAsFixed(0) ?? '0'}',
      );
    }).toList();
  });
});

final roomTypeListProvider = StreamProvider<List<RoomTypeModel>>((ref) {
  return ref.watch(roomRepositoryProvider).getRoomTypes();
});

final rawRoomListProvider = StreamProvider<List<RoomModel>>((ref) {
  return ref.watch(roomRepositoryProvider).getRooms();
});

class RoomController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  RoomController(this._ref) : super(const AsyncValue.data(null));

  Future<void> addRoom(RoomModel room) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _ref.read(roomRepositoryProvider).addRoom(room);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (success) => success,
      );
    });
  }

  Future<void> updateRoomStatus(String roomId, String status,
      {String? tenantName}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final rooms = await _ref.read(roomRepositoryProvider).getRooms().first;
      final roomModel = rooms.firstWhereOrNull((r) => r.id == roomId);

      if (roomModel != null) {
        RoomModel toSave = roomModel;

        if (status == 'Terisi') {
          toSave =
              roomModel.copyWith(isActive: true, currentTenantName: tenantName);
        } else if (status == 'Kosong') {
          toSave = roomModel.copyWith(isActive: true, currentTenantName: null);
        } else if (status == 'Non-Aktif') {
          toSave = roomModel.copyWith(isActive: false);
        }

        final result =
            await _ref.read(roomRepositoryProvider).updateRoom(toSave);
        return result.fold(
          (failure) => throw Exception(failure.message),
          (success) => success,
        );
      }
    });
  }

  Future<void> addRoomType(RoomTypeModel type) async {
    state = const AsyncValue.loading();
    try {
      final result = await _ref.read(roomRepositoryProvider).addRoomType(type);
      result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (success) {
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateRoomType(RoomTypeModel type) async {
    state = const AsyncValue.loading();
    try {
      final result =
          await _ref.read(roomRepositoryProvider).updateRoomType(type);
      result.fold(
        (failure) =>
            state = AsyncValue.error(failure.message, StackTrace.current),
        (success) => state = const AsyncValue.data(null),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteRoomType(String typeId) async {
    state = const AsyncValue.loading();
    try {
      // Validation: Check if any room uses this type
      final rooms = await _ref.read(roomRepositoryProvider).getRooms().first;
      final isUsed = rooms.any((r) => r.roomTypeId == typeId);

      if (isUsed) {
        throw Exception(
            'Tidak bisa menghapus tipe ini karena sedang digunakan oleh kamar.');
      }

      final result =
          await _ref.read(roomRepositoryProvider).deleteRoomType(typeId);
      result.fold(
        (failure) =>
            state = AsyncValue.error(failure.message, StackTrace.current),
        (success) => state = const AsyncValue.data(null),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final roomControllerProvider =
    StateNotifierProvider<RoomController, AsyncValue<void>>((ref) {
  return RoomController(ref);
});
