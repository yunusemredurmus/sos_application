import 'package:sos_application/feature/home/alergies/dto/alergies_dto.dart';

abstract class IAlergiesService {
  Future<List<AlergiesDto>> getAlergies();
  Future<void> addAlergies(AlergiesDto alergiesDto);
  Future<void> deleteAlergies(String id);
}
