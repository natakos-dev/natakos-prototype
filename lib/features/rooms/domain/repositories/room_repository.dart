import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/room_model.dart';
import '../../data/models/room_type_model.dart';

abstract class RoomRepository {
  // Rooms
  Stream<List<RoomModel>> getRooms();
  Future<Either<Failure, void>> addRoom(RoomModel room);
  Future<Either<Failure, void>> updateRoom(RoomModel room);
  Future<Either<Failure, void>> deleteRoom(String roomId);

  // Room Types
  Stream<List<RoomTypeModel>> getRoomTypes();
  Future<Either<Failure, void>> addRoomType(RoomTypeModel type);
  Future<Either<Failure, void>> updateRoomType(RoomTypeModel type);
  Future<Either<Failure, void>> deleteRoomType(String typeId);
}
