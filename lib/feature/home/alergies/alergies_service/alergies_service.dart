import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_application/feature/home/alergies/alergies_service/i_alergies_service.dart';
import 'package:sos_application/feature/home/alergies/dto/alergies_dto.dart';

class AlergiesService implements IAlergiesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<AlergiesDto>> getAlergies() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> data =
          await _firestore.collection('alergies').get();
      return data.docs.map((e) => AlergiesDto.fromMap(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addAlergies(AlergiesDto alergi) async {
    try {
      await _firestore
          .collection('alergies')
          .doc(alergi.id)
          .set(alergi.toMap());
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> deleteAlergies(String id) async {
    try {
      await _firestore.collection('alergies').doc(id).delete();
    } catch (e) {
      return;
    }
  }
  
}
