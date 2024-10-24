import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_inherited.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpInherited = SignUpInherited.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      body: BlocContext<SignUpCubit, SignUpState>(
        builder: (context, cubit) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crear una cuenta',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '¡Bienvenido! Por favor ingresa tus datos',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: signUpInherited.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldCustomPro(
                          controller: signUpInherited.idCompany,
                          label: 'ID compañia',
                        ),
                        TextFieldCustomPro(
                          controller: signUpInherited.user,
                          label: 'Usuario',
                        ),
                        TextFieldCustomPro(
                          controller: signUpInherited.name,
                          label: 'Nombre',
                        ),
                        TextFieldCustomPro(
                          controller: signUpInherited.password,
                          isPassword: true,
                          label: 'Contraseña',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonCustom(
                          onPressed: () {
                            final validResult = signUpInherited.valid();
                            if (validResult.isPassed) {
                              cubit.register(
                                idCompany: signUpInherited
                                    .idCompany.textEditingController.text,
                                name: signUpInherited
                                    .name.textEditingController.text,
                                user: signUpInherited
                                    .user.textEditingController.text,
                                password: signUpInherited
                                    .password.textEditingController.text,
                              );
                            }
                          },
                          text: 'Registrar',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '¿Ya tienes una cuenta?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
