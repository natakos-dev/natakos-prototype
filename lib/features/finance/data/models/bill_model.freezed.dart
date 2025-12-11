// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BillItemModel _$BillItemModelFromJson(Map<String, dynamic> json) {
  return _BillItemModel.fromJson(json);
}

/// @nodoc
mixin _$BillItemModel {
  String get description => throw _privateConstructorUsedError; // deskripsi
  int get quantity => throw _privateConstructorUsedError; // qty
  double get price => throw _privateConstructorUsedError; // hargaSatuan
  double get total => throw _privateConstructorUsedError; // subtotal
  String? get otherCostId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillItemModelCopyWith<BillItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillItemModelCopyWith<$Res> {
  factory $BillItemModelCopyWith(
          BillItemModel value, $Res Function(BillItemModel) then) =
      _$BillItemModelCopyWithImpl<$Res, BillItemModel>;
  @useResult
  $Res call(
      {String description,
      int quantity,
      double price,
      double total,
      String? otherCostId});
}

/// @nodoc
class _$BillItemModelCopyWithImpl<$Res, $Val extends BillItemModel>
    implements $BillItemModelCopyWith<$Res> {
  _$BillItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
    Object? total = null,
    Object? otherCostId = freezed,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      otherCostId: freezed == otherCostId
          ? _value.otherCostId
          : otherCostId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillItemModelImplCopyWith<$Res>
    implements $BillItemModelCopyWith<$Res> {
  factory _$$BillItemModelImplCopyWith(
          _$BillItemModelImpl value, $Res Function(_$BillItemModelImpl) then) =
      __$$BillItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      int quantity,
      double price,
      double total,
      String? otherCostId});
}

/// @nodoc
class __$$BillItemModelImplCopyWithImpl<$Res>
    extends _$BillItemModelCopyWithImpl<$Res, _$BillItemModelImpl>
    implements _$$BillItemModelImplCopyWith<$Res> {
  __$$BillItemModelImplCopyWithImpl(
      _$BillItemModelImpl _value, $Res Function(_$BillItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? price = null,
    Object? total = null,
    Object? otherCostId = freezed,
  }) {
    return _then(_$BillItemModelImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      otherCostId: freezed == otherCostId
          ? _value.otherCostId
          : otherCostId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillItemModelImpl implements _BillItemModel {
  const _$BillItemModelImpl(
      {required this.description,
      required this.quantity,
      required this.price,
      required this.total,
      this.otherCostId});

  factory _$BillItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillItemModelImplFromJson(json);

  @override
  final String description;
// deskripsi
  @override
  final int quantity;
// qty
  @override
  final double price;
// hargaSatuan
  @override
  final double total;
// subtotal
  @override
  final String? otherCostId;

  @override
  String toString() {
    return 'BillItemModel(description: $description, quantity: $quantity, price: $price, total: $total, otherCostId: $otherCostId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillItemModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.otherCostId, otherCostId) ||
                other.otherCostId == otherCostId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, quantity, price, total, otherCostId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillItemModelImplCopyWith<_$BillItemModelImpl> get copyWith =>
      __$$BillItemModelImplCopyWithImpl<_$BillItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillItemModelImplToJson(
      this,
    );
  }
}

abstract class _BillItemModel implements BillItemModel {
  const factory _BillItemModel(
      {required final String description,
      required final int quantity,
      required final double price,
      required final double total,
      final String? otherCostId}) = _$BillItemModelImpl;

  factory _BillItemModel.fromJson(Map<String, dynamic> json) =
      _$BillItemModelImpl.fromJson;

  @override
  String get description;
  @override // deskripsi
  int get quantity;
  @override // qty
  double get price;
  @override // hargaSatuan
  double get total;
  @override // subtotal
  String? get otherCostId;
  @override
  @JsonKey(ignore: true)
  _$$BillItemModelImplCopyWith<_$BillItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillModel _$BillModelFromJson(Map<String, dynamic> json) {
  return _BillModel.fromJson(json);
}

/// @nodoc
mixin _$BillModel {
  String get id => throw _privateConstructorUsedError; // Firestore ID
  String get contractId => throw _privateConstructorUsedError; // kontrakId
  DateTime get period =>
      throw _privateConstructorUsedError; // periode (Month-Year)
  DateTime get dueDate => throw _privateConstructorUsedError; // tglJatuhTempo
  double get totalAmount => throw _privateConstructorUsedError; // totalTagihan
  String get status =>
      throw _privateConstructorUsedError; // statusBayar: 'Unpaid', 'Paid', 'Partial'
  List<BillItemModel> get items =>
      throw _privateConstructorUsedError; // embedded DetailTagihan
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillModelCopyWith<BillModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillModelCopyWith<$Res> {
  factory $BillModelCopyWith(BillModel value, $Res Function(BillModel) then) =
      _$BillModelCopyWithImpl<$Res, BillModel>;
  @useResult
  $Res call(
      {String id,
      String contractId,
      DateTime period,
      DateTime dueDate,
      double totalAmount,
      String status,
      List<BillItemModel> items,
      String? notes});
}

/// @nodoc
class _$BillModelCopyWithImpl<$Res, $Val extends BillModel>
    implements $BillModelCopyWith<$Res> {
  _$BillModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contractId = null,
    Object? period = null,
    Object? dueDate = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contractId: null == contractId
          ? _value.contractId
          : contractId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BillItemModel>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillModelImplCopyWith<$Res>
    implements $BillModelCopyWith<$Res> {
  factory _$$BillModelImplCopyWith(
          _$BillModelImpl value, $Res Function(_$BillModelImpl) then) =
      __$$BillModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String contractId,
      DateTime period,
      DateTime dueDate,
      double totalAmount,
      String status,
      List<BillItemModel> items,
      String? notes});
}

/// @nodoc
class __$$BillModelImplCopyWithImpl<$Res>
    extends _$BillModelCopyWithImpl<$Res, _$BillModelImpl>
    implements _$$BillModelImplCopyWith<$Res> {
  __$$BillModelImplCopyWithImpl(
      _$BillModelImpl _value, $Res Function(_$BillModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contractId = null,
    Object? period = null,
    Object? dueDate = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(_$BillModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contractId: null == contractId
          ? _value.contractId
          : contractId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BillItemModel>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillModelImpl implements _BillModel {
  const _$BillModelImpl(
      {required this.id,
      required this.contractId,
      required this.period,
      required this.dueDate,
      required this.totalAmount,
      this.status = 'Unpaid',
      required final List<BillItemModel> items,
      this.notes})
      : _items = items;

  factory _$BillModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillModelImplFromJson(json);

  @override
  final String id;
// Firestore ID
  @override
  final String contractId;
// kontrakId
  @override
  final DateTime period;
// periode (Month-Year)
  @override
  final DateTime dueDate;
// tglJatuhTempo
  @override
  final double totalAmount;
// totalTagihan
  @override
  @JsonKey()
  final String status;
// statusBayar: 'Unpaid', 'Paid', 'Partial'
  final List<BillItemModel> _items;
// statusBayar: 'Unpaid', 'Paid', 'Partial'
  @override
  List<BillItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

// embedded DetailTagihan
  @override
  final String? notes;

  @override
  String toString() {
    return 'BillModel(id: $id, contractId: $contractId, period: $period, dueDate: $dueDate, totalAmount: $totalAmount, status: $status, items: $items, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contractId, contractId) ||
                other.contractId == contractId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, contractId, period, dueDate,
      totalAmount, status, const DeepCollectionEquality().hash(_items), notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillModelImplCopyWith<_$BillModelImpl> get copyWith =>
      __$$BillModelImplCopyWithImpl<_$BillModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillModelImplToJson(
      this,
    );
  }
}

abstract class _BillModel implements BillModel {
  const factory _BillModel(
      {required final String id,
      required final String contractId,
      required final DateTime period,
      required final DateTime dueDate,
      required final double totalAmount,
      final String status,
      required final List<BillItemModel> items,
      final String? notes}) = _$BillModelImpl;

  factory _BillModel.fromJson(Map<String, dynamic> json) =
      _$BillModelImpl.fromJson;

  @override
  String get id;
  @override // Firestore ID
  String get contractId;
  @override // kontrakId
  DateTime get period;
  @override // periode (Month-Year)
  DateTime get dueDate;
  @override // tglJatuhTempo
  double get totalAmount;
  @override // totalTagihan
  String get status;
  @override // statusBayar: 'Unpaid', 'Paid', 'Partial'
  List<BillItemModel> get items;
  @override // embedded DetailTagihan
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$BillModelImplCopyWith<_$BillModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
