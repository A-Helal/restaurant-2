import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu_item_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _menuItemsCollection =>
      _firestore.collection('menu_items');

  Future<List<MenuItem>> getMenuItems() async {
    try {
      final querySnapshot = await _menuItemsCollection
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => MenuItem.fromJson(
          doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch menu items: ${e.toString()}');
    }
  }
}
