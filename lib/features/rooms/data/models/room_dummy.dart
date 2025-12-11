class Room {
  final String id;
  final String roomNumber;
  final String status; // 'Terisi', 'Kosong'
  final String? tenantName;
  final String type;
  final String price;

  Room({
    required this.id,
    required this.roomNumber,
    required this.status,
    this.tenantName,
    required this.type,
    required this.price,
  });
}

final List<Room> dummyRooms = [
  Room(
    id: '1',
    roomNumber: '101',
    status: 'Terisi',
    tenantName: 'Budi Santoso',
    type: 'Standard AC',
    price: 'Rp 1.500.000',
  ),
  Room(
    id: '2',
    roomNumber: '102',
    status: 'Kosong',
    type: 'Standard AC',
    price: 'Rp 1.500.000',
  ),
  Room(
    id: '3',
    roomNumber: '103',
    status: 'Terisi',
    tenantName: 'Siti Aminah',
    type: 'Standard AC',
    price: 'Rp 1.500.000',
  ),
  Room(
    id: '4',
    roomNumber: '104',
    status: 'Kosong',
    type: 'VIP',
    price: 'Rp 2.000.000',
  ),
  Room(
    id: '5',
    roomNumber: '201',
    status: 'Terisi',
    tenantName: 'Ahmad Rizky',
    type: 'VIP',
    price: 'Rp 2.000.000',
  ),
  Room(
    id: '6',
    roomNumber: '202',
    status: 'Kosong',
    type: 'VIP',
    price: 'Rp 2.000.000',
  ),
];
