import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia_refactored/firebase/database/schema.dart';

class Customer {
  String? name;
  String? email;
  String? phone;
  String? address;

  Customer({this.name, this.email, this.phone, this.address});
  Customer.fromDocument(DocumentSnapshot doc) {
    name = doc.get(CustomerFields.name);
    email = doc.get(CustomerFields.email);
    phone = doc.get(CustomerFields.phone);
    address = doc.get(CustomerFields.address);
  }
}
