import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia_refactored/firebase/database/schema.dart';
import 'package:eatopia_refactored/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbServices {
  static final db = FirebaseFirestore.instance;

  static Future<Customer> getCustomer(String uid) async {
    final docSnapshot = await db.collection('Customers').doc(uid).get();
    return Customer.fromDocument(docSnapshot);
  }

  static Future<bool> isCustomer(User user) async {
    final docSnapshot = await db.collection('Customers').doc(user.uid).get();
    if (docSnapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> addCustomer(Customer customer, String uid) async {
    final docRef = db.collection(Collections.customers).doc(uid);
    await docRef.set({
      CustomerFields.name: customer.name,
      CustomerFields.email: customer.email,
      CustomerFields.phone: customer.phone,
      CustomerFields.address: customer.address,
    });
  }
}
