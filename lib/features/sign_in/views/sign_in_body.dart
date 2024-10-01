import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/views/sign_in_inherited.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_page.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = SignInInherited.of(context);
    final notification = context.read<NotifyDialogHandlerCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocContext<SignInCubit, SignInState>(
        builder: (context, cubit) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.bolt,
                              weight: 3,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              indent: 1,
                              endIndent: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inicia sesión en tu cuenta',
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          //color: Color.fromARGB(52, 29, 29, 29),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Form(
                          key: inherited.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.idCompany,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  //DecimalTextInputFormatter(decimalRange: 3),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,3}'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo del ID compañia requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'ID compañia',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.person_2_rounded),
                                controller: inherited.user,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Usuario requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Usuario',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.security),
                                controller: inherited.password,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo contraseña requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                isPassword: true,
                                label: 'Contraseña',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ButtonCustom(
                                onPressed: () {
                                  final validResult = inherited.valid();
                                  if (validResult.isPassed) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    cubit.login(
                                      userName: inherited
                                          .user.textEditingController.text,
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
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '¿No tiene una cuenta?',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.push(SignUpPage.route());
                                    },
                                    child: const Text(
                                      'Regístrate',
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
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
