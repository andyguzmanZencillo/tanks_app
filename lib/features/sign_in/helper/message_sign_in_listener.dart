import 'package:tanks_app/core/helpers/dialog_info.dart';

class SignInMessages {
  static const loading = DialogMessage(message: 'Iniciando sesión...');
  static const success = DialogMessage(
    message: 'Inicio de sesión exitoso.',
    showSuccess: false,
  );
  static const error = DialogMessage(
    message:
        'Error al iniciar sesión. Por favor, verifique sus credenciales e intente de nuevo.',
  );
}
