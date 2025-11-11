class ValidationResult {
  final bool isValid;
  final String message;

  ValidationResult({required this.isValid, required this.message});

  @override
  String toString() {
    return 'ValidationResult (isValid: $isValid, message: "$message")';
  }
}
