class PigeonUserDetails {
  final String uid;
  final String email;
  final String name; // optional, if you store admin name

  PigeonUserDetails({
    required this.uid,
    required this.email,
    required this.name,
  });

  // Convert Firestore document data to PigeonUserDetails
  factory PigeonUserDetails.fromMap(Map<String, dynamic> map) {
    return PigeonUserDetails(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  // Optional: convert to map (if needed for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
