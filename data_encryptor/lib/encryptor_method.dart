// This data encryptor method was seperated from the UI for reusability purpose.
// Now you can reuse this method elsewhere by just calling it.


class EncryptionMethod {
  // Encrypts a given text using a custom shift & reverse algorithm.
  // Each character is shifted forward based on the secret key.
  // The result is then reversed for added security.
  // The final output is converted to a hexadecimal string.
  static String encrypt(String text, String key) {
    List<int> encrypted = [];

    for (int i = 0; i < text.length; i++) {
      int shift = key.codeUnitAt(i % key.length);
      
      // Shift character by adding the shift value (mod 256 to stay within ASCII range)
      encrypted.add((text.codeUnitAt(i) + shift) % 256);
    }

    // Reverse the list to add extra security
    return encrypted.reversed
        .map((e) => e.toRadixString(16).padLeft(2, '0')) // Convert to hexadecimal
        .join();
  }

  // Decrypts an encrypted text back to its original form.
  // Converts the hexadecimal string back to numbers.
  // Reverses the order to undo encryption.
  // Shifts characters backward using the same key.
  static String decrypt(String encryptedText, String key) {
    List<int> encrypted = [];

    // Convert the hex string back to a list of integers
    for (int i = 0; i < encryptedText.length; i += 2) {
      encrypted.add(int.parse(encryptedText.substring(i, i + 2), radix: 16));
    }

    // Reverse the list to restore original order
    encrypted = encrypted.reversed.toList();

    String decrypted = '';
    for (int i = 0; i < encrypted.length; i++) {
      // Get the same shift value used in encryption
      int shift = key.codeUnitAt(i % key.length);

      // Reverse the shift operation to get back the original character
      decrypted += String.fromCharCode((encrypted[i] - shift + 256) % 256);
    }

    return decrypted;
  }
}

// Encrypted data are stored in the setState method temporarily. 
// For solid and permanent storage, sharedPrefence can be considered or even usage of database, that way encrypted data’s won’t go missing if you reload the app.


