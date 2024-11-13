import 'package:json_annotation/json_annotation.dart';
part 'notifi.g.dart';

@JsonSerializable()
class Notifi {
  final String mess;

  Notifi({required this.mess});
  factory Notifi.fromJson(Map<String, dynamic> json) => _$NotifiFromJson(json);
  Map<String, dynamic> toJson() => _$NotifiToJson(this);
}
