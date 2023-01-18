
enum FirestoreCollections {
  users("users");

  final String value;
  const FirestoreCollections(this.value);
}

enum FirestoreSubCollections {
  todos("todos");

  final String value;
  const FirestoreSubCollections(this.value);
}