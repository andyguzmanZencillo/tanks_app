import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/constans/assets.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_password.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/helper/sign_in_inherited.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = SignInInherited.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocContext<SignInCubit, SignInState>(
        builder: (context, cubit) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  Assets.logo,
                  width: 130,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    children: [
                      Text(
                        'Inicia sesión en tu cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '¡Bienvenido de nuevo! Por favor, ingresa tus datos.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: inherited.formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldCustomNew(
                          controller: inherited.idCompany,
                          label: 'ID compañia',
                          title: 'ID compañia',
                        ),
                        TextFieldCustomNew(
                          controller: inherited.user,
                          title: 'Usuario o correo electrónico',
                          label: 'Usuario o correo electrónico',
                        ),
                        TextFieldCustomPassword(
                          controller: inherited.password,
                          title: 'Contraseña',
                          label: 'Contraseña',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonCustom(
                          onPressed: () {
                            final validResult = inherited.valid();
                            if (validResult.isPassed) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              cubit.login(
                                userName:
                                    inherited.user.textEditingController.text,
                                password: inherited
                                    .password.textEditingController.text,
                                idCompany: inherited
                                    .idCompany.textEditingController.text,
                              );
                            }
                          },
                          text: 'Iniciar Sesión',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                await launchUrl(
                                  Uri.parse(
                                    'https://zencillo.com/powered-by-zencillo/',
                                  ),
                                );
                              },
                              child: const Text(
                                '¿No tiene una cuenta?',
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
