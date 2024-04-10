class StorageException implements Exception {
  final String message;

  StorageException(this.message);

  @override
  String toString() => "StorageException: $message";
}

class FirestoreException implements Exception {
  final String message;

  FirestoreException(this.message);

  @override
  String toString() => "FirestoreException: $message";
}

class UploadException implements Exception {
  final String message;

  UploadException(this.message);

  @override
  String toString() => "UploadException: $message";
}

class DeleteException implements Exception {
  final String message;

  DeleteException(this.message);

  @override
  String toString() => "DeleteException: $message";
}
