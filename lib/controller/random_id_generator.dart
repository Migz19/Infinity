 import 'dart:math';

String generateRandomDocId() {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final secureRandom = Random.secure();
  final buffer = StringBuffer();
  for (int i = 0; i < 36; i++) {
    final randomIndex = secureRandom.nextInt(chars.length);
    buffer.write(chars[randomIndex]);
  }
  return buffer.toString();
}