import 'dart:async';
import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/providers/shared_prefs_provider.dart';
import '../../domain/repositories/room_repository.dart';
import '../models/room_model.dart';
import '../models/room_type_model.dart';

part 'room_repository_impl.g.dart';

@Riverpod(keepAlive: true)
RoomRepository roomRepository(RoomRepositoryRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider).asData!.value;
  return RoomRepositoryLocalImpl(prefs);
}

class RoomRepositoryLocalImpl implements RoomRepository {
  final SharedPreferences _prefs;
  final _roomsController = BehaviorSubject<List<RoomModel>>();
  final _roomTypesController = BehaviorSubject<List<RoomTypeModel>>();

  // Cache
  List<RoomModel> _rooms = [];
  List<RoomTypeModel> _roomTypes = [];
  bool _initialized = false;

  RoomRepositoryLocalImpl(this._prefs);

  void _init() {
    if (_initialized) return;
    _initialized = true;

    // Load Rooms
    final roomsJson = _prefs.getString('local_rooms');
    if (roomsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(roomsJson);
        _rooms = decoded.map((e) => RoomModel.fromJson(e)).toList();
      } catch (e) {
        print('Error decoding rooms: $e');
        _rooms = [];
      }
    }
    _roomsController.add(_rooms);

    // Load Room Types
    final typesJson = _prefs.getString('local_room_types');
    if (typesJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(typesJson);
        _roomTypes = decoded.map((e) => RoomTypeModel.fromJson(e)).toList();
      } catch (e) {
        print('Error decoding room types: $e');
        _roomTypes = [];
      }
    }
    _roomTypesController.add(_roomTypes);
  }

  Future<void> _saveRooms() async {
    final encoded = jsonEncode(_rooms.map((e) => e.toJson()).toList());
    await _prefs.setString('local_rooms', encoded);
    _roomsController.add(_rooms);
  }

  Future<void> _saveRoomTypes() async {
    final encoded = jsonEncode(_roomTypes.map((e) => e.toJson()).toList());
    await _prefs.setString('local_room_types', encoded);
    _roomTypesController.add(_roomTypes);
  }

  @override
  Stream<List<RoomModel>> getRooms() {
    if (!_initialized) _init();
    // Ensure we emit the current value immediately if available
    Future.microtask(() {
      if (!_roomsController.hasValue) {
        _roomsController.add(_rooms);
      }
    });
    return _roomsController.stream;
  }

  @override
  Stream<List<RoomTypeModel>> getRoomTypes() {
    if (!_initialized) _init();
    Future.microtask(() {
      if (!_roomTypesController.hasValue) {
        _roomTypesController.add(_roomTypes);
      }
    });
    return _roomTypesController.stream;
  }

  @override
  Future<Either<Failure, RoomModel>> getRoom(String roomId) async {
    if (!_initialized) _init();
    try {
      final room = _rooms.firstWhere((r) => r.id == roomId);
      return right(room);
    } catch (e) {
      return left(ServerFailure('Room not found'));
    }
  }

  @override
  Future<Either<Failure, void>> addRoom(RoomModel room) async {
    try {
      if (!_initialized) _init();
      final newRoom = room.copyWith(
        id: room.id.isEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : room.id,
      );
      _rooms.add(newRoom);
      await _saveRooms();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateRoom(RoomModel room) async {
    try {
      if (!_initialized) _init();
      final index = _rooms.indexWhere((r) => r.id == room.id);
      if (index != -1) {
        _rooms[index] = room;
        await _saveRooms();
        return right(null);
      }
      return left(ServerFailure('Room not found'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoom(String roomId) async {
    try {
      if (!_initialized) _init();
      _rooms.removeWhere((r) => r.id == roomId);
      await _saveRooms();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addRoomType(RoomTypeModel type) async {
    try {
      if (!_initialized) _init();
      final newType = type.copyWith(
        id: type.id.isEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : type.id,
      );
      _roomTypes.add(newType);
      await _saveRoomTypes();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateRoomType(RoomTypeModel type) async {
    try {
      if (!_initialized) _init();
      final index = _roomTypes.indexWhere((t) => t.id == type.id);
      if (index != -1) {
        _roomTypes[index] = type;
        await _saveRoomTypes();
        return right(null);
      }
      return left(ServerFailure('Room type not found'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoomType(String typeId) async {
    try {
      if (!_initialized) _init();
      _roomTypes.removeWhere((t) => t.id == typeId);
      await _saveRoomTypes();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
