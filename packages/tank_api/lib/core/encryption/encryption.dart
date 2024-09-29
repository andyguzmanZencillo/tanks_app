import 'package:encrypt/encrypt.dart';
import 'package:tank_api/core/config/config.dart';

class Encryption {
  static String encrypt(String plainText) {
    // Assign password or key to encrypt
    final key = Key.fromUtf8(Config.encryptionKey);
    // Here define size key or password
    final iv = IV.fromLength(16);
    // Assign parrameters encription AES, ECB, Key,PKCS7
    final encrypter = Encrypter(
      AES(key, mode: AESMode.ecb),
    );
    // Asign to encrypted the text encrypted
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // Return encrypted, but converted to base 64,
    // with that is understandable string
    return encrypted.base64;
  }

  static String decrypt(String plainText) {
    // Assign password or key to encrypt
    final key = Key.fromUtf8(Config.encryptionKey);
    // Here define size key or password
    final iv = IV.fromLength(16);
    // Assign parrameters encription AES, ECB, Key,PKCS7
    final encrypter = Encrypter(
      AES(key, mode: AESMode.ecb),
    );
    //  Remove LF
    final plainTextWithoutLF = plainText.replaceAll('\n', '');
    //  Remove CR
    final plainTextWithoutLFCR = plainTextWithoutLF.replaceAll(
      '\r',
      '',
    );
    //  Decrypt string
    final decryptedData = encrypter.decrypt(
      Encrypted.fromBase64(
        plainTextWithoutLFCR,
      ),
      iv: iv,
    );
    // Return decrypted data
    return decryptedData;
  }
}
