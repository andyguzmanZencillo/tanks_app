import 'package:tank_api/core/extends/json_extends.dart';
import 'package:tank_api/features/features.dart';
import 'package:tank_api/features/tank_variation/models/tank_variation_last_response.dart';

class TankVariationMultiResponse {
  TankVariationMultiResponse({
    required this.tank,
    required this.tankVariation,
    required this.tanksVariationLast,
  });

  factory TankVariationMultiResponse.fromJson(Map<String, dynamic> json) {
    // final tankMap = json.get<Map<String, dynamic>>('tank', {});
    final tankVariationMap = json.get<List<dynamic>>('datos', []);
    final tankVariationLastMap =
        json.get<List<dynamic>>('datos_dia_anterior', []);
    return TankVariationMultiResponse(
      tank: TanksResponse.fromJson(json),
      tankVariation: tankVariationMap
          .map((e) => TankVariationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      tanksVariationLast: tankVariationLastMap
          .map(
            (e) =>
                TankVariationLastResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
  final TanksResponse tank;
  final List<TankVariationResponse> tankVariation;
  final List<TankVariationLastResponse> tanksVariationLast;
}
