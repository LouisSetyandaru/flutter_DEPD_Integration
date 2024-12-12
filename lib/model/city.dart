import 'package:equatable/equatable.dart';
class City extends Equatable {
  final String? cityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;
  const City({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });
  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json['city_id'] as String?,
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
        type: json['type'] as String?,
        cityName: json['city_name'] as String?,
        postalCode: json['postal_code'] as String?,
      );
  Map<String, dynamic> toJson() => {
        'city_id': cityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };
  @override
  List<Object?> get props {
    return [
      cityId,
      provinceId,
      province,
      type,
      cityName,
      postalCode,
    ];
  }
}

//----Back Up Code ----

// import 'package:collection/collection.dart';

// class City {
//   String? cityId;
//   String? provinceId;
//   String? province;
//   String? type;
//   String? cityName;
//   String? postalCode;

//   City({
//     this.cityId,
//     this.provinceId,
//     this.province,
//     this.type,
//     this.cityName,
//     this.postalCode,
//   });

//   factory City.fromJson(Map<String, dynamic> json) => City(
//         cityId: json['city_id'] as String?,
//         provinceId: json['province_id'] as String?,
//         province: json['province'] as String?,
//         type: json['type'] as String?,
//         cityName: json['city_name'] as String?,
//         postalCode: json['postal_code'] as String?,
//       );

//   Map<String, dynamic> toJson() => {
//         'city_id': cityId,
//         'province_id': provinceId,
//         'province': province,
//         'type': type,
//         'city_name': cityName,
//         'postal_code': postalCode,
//       };

//   @override
// //     List<Object?> get props {
// //     return [
// //       cityId,
// //       provinceId,
// //       province,
// //       type,
// //       cityName,
// //       postalCode,
// //     ];
// //   }
// // }

//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! City) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toJson(), toJson());
//   }

//   @override
//   int get hashCode =>
//       cityId.hashCode ^
//       provinceId.hashCode ^
//       province.hashCode ^
//       type.hashCode ^
//       cityName.hashCode ^
//       postalCode.hashCode;
// }
