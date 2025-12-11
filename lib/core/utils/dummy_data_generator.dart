import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/finance/data/models/transaction_model.dart';
import '../../features/finance/data/repositories/transaction_repository_impl.dart';
import '../../features/rooms/data/models/room_model.dart';
import '../../features/rooms/data/models/room_type_model.dart';
import '../../features/rooms/data/repositories/room_repository_impl.dart';
import '../../features/tenants/data/models/tenant_model.dart';
import '../../features/tenants/data/repositories/tenant_repository_impl.dart';

class DummyDataGenerator {
  static Future<void> generate(WidgetRef ref) async {
    final roomRepo = ref.read(roomRepositoryProvider);
    final tenantRepo = ref.read(tenantRepositoryProvider);
    final transactionRepo = ref.read(transactionRepositoryProvider);

    // 1. Room Types
    final types = [
      RoomTypeModel(
        id: 'type_1',
        name: 'Standard',
        monthlyPrice: 800000,
        description: 'Kamar mandi luar',
        facilities: ['Kasur', 'Lemari', 'Meja'],
      ),
      RoomTypeModel(
        id: 'type_2',
        name: 'Deluxe',
        monthlyPrice: 1200000,
        description: 'Kamar mandi dalam',
        facilities: ['Kasur', 'Lemari', 'Meja', 'Kamar Mandi Dalam', 'AC'],
      ),
    ];

    for (var t in types) {
      await roomRepo.addRoomType(t);
    }

    // 2. Tenants & Rooms
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));
    final twoMonthsAgo = now.subtract(const Duration(days: 60));

    // Tenant 1: Aman (Paid recently, due date next month)
    final tenant1 = TenantModel(
      id: 'tenant_1',
      fullName: 'Budi Santoso',
      phoneNumber: '081234567890',
      nik: '1234567890123456',
      originAddress: 'Surabaya',
      entryDate: twoMonthsAgo.toIso8601String(),
      nextDueDate: now.add(const Duration(days: 20)).toIso8601String(), // Safe
      notes: 'Kamar: room_101',
    );

    // Tenant 2: Hampir Tempo (Due in 3 days)
    final tenant2 = TenantModel(
      id: 'tenant_2',
      fullName: 'Siti Aminah',
      phoneNumber: '081298765432',
      nik: '6543210987654321',
      originAddress: 'Malang',
      entryDate: lastMonth.toIso8601String(),
      nextDueDate:
          now.add(const Duration(days: 3)).toIso8601String(), // Warning
      notes: 'Kamar: room_102',
    );

    // Tenant 3: Telat Bayar (Due 2 days ago)
    final tenant3 = TenantModel(
      id: 'tenant_3',
      fullName: 'Andi Pratama',
      phoneNumber: '081333444555',
      nik: '1122334455667788',
      originAddress: 'Jakarta',
      entryDate: twoMonthsAgo.toIso8601String(),
      nextDueDate:
          now.subtract(const Duration(days: 5)).toIso8601String(), // Overdue
      notes: 'Kamar: room_103',
    );

    await tenantRepo.addTenant(tenant1);
    await tenantRepo.addTenant(tenant2);
    await tenantRepo.addTenant(tenant3);

    // Rooms
    final rooms = [
      RoomModel(
        id: 'room_101',
        roomNumber: '101',
        floor: 1,
        roomTypeId: 'type_2', // Deluxe
        status: 'Terisi',
        currentTenantName: 'Budi Santoso',
      ),
      RoomModel(
        id: 'room_102',
        roomNumber: '102',
        floor: 1,
        roomTypeId: 'type_1', // Standard
        status: 'Terisi',
        currentTenantName: 'Siti Aminah',
      ),
      RoomModel(
        id: 'room_103',
        roomNumber: '103',
        floor: 1,
        roomTypeId: 'type_1',
        status: 'Terisi',
        currentTenantName: 'Andi Pratama',
      ),
      RoomModel(
        id: 'room_104',
        roomNumber: '104',
        floor: 1,
        roomTypeId: 'type_1',
        status: 'Kosong',
      ),
      RoomModel(
        id: 'room_201',
        roomNumber: '201',
        floor: 2,
        roomTypeId: 'type_2',
        status: 'Kosong',
      ),
    ];

    for (var r in rooms) {
      await roomRepo.addRoom(r);
    }

    // 3. Transactions (History)
    // Budi paid last month and this month
    await transactionRepo.addTransaction(TransactionModel(
      id: 'trans_1',
      type: TransactionType.income,
      amount: 1200000,
      date: twoMonthsAgo,
      category: 'Pembayaran Sewa',
      description: 'Sewa Oktober - Budi',
      paymentMethod: 'Tunai',
      relatedId: 'tenant_1',
      relatedName: 'Budi Santoso',
    ));

    await transactionRepo.addTransaction(TransactionModel(
      id: 'trans_2',
      type: TransactionType.income,
      amount: 1200000,
      date: lastMonth,
      category: 'Pembayaran Sewa',
      description: 'Sewa November - Budi',
      paymentMethod: 'Transfer',
      relatedId: 'tenant_1',
      relatedName: 'Budi Santoso',
    ));

    // Siti paid last month
    await transactionRepo.addTransaction(TransactionModel(
      id: 'trans_3',
      type: TransactionType.income,
      amount: 800000,
      date: lastMonth,
      category: 'Pembayaran Sewa',
      description: 'Sewa November - Siti',
      paymentMethod: 'Tunai',
      relatedId: 'tenant_2',
      relatedName: 'Siti Aminah',
    ));

    // Andi Paid 2 months ago, missed last month
    await transactionRepo.addTransaction(TransactionModel(
      id: 'trans_4',
      type: TransactionType.income,
      amount: 800000,
      date: twoMonthsAgo,
      category: 'Pembayaran Sewa',
      description: 'Sewa Oktober - Andi',
      paymentMethod: 'Transfer',
      relatedId: 'tenant_3',
      relatedName: 'Andi Pratama',
    ));

    // Expenses
    await transactionRepo.addTransaction(TransactionModel(
      id: 'exp_1',
      type: TransactionType.expense,
      amount: 450000,
      date: lastMonth,
      category: 'Listrik',
      description: 'Token Listrik Utama',
      paymentMethod: 'Tunai',
    ));

    await transactionRepo.addTransaction(TransactionModel(
      id: 'exp_2',
      type: TransactionType.expense,
      amount: 150000,
      date: lastMonth.add(const Duration(days: 5)),
      category: 'Air',
      description: 'PDAM',
      paymentMethod: 'Tunai',
    ));
  }
}
