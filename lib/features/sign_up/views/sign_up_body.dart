import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_inherited.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpInherited = SignUpInherited.of(context);
    final cubitNoti = context.read<NotifyDialogHandlerCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      body: BlocContext<SignUpCubit, SignUpState>(
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
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.bolt,
                              weight: 3,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.white,
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
                              fontWeight: FontWeight.w300,
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
                          key: signUpInherited.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: signUpInherited.idCompany,
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
                                icon: const Icon(Icons.person),
                                controller: signUpInherited.user,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo usuario requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Usuario',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.person),
                                controller: signUpInherited.name,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo nombre requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Nombre',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.security),
                                controller: signUpInherited.password,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo contraseña requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
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
                                      user: signUpInherited
                                          .user.textEditingController.text,
                                      password: signUpInherited
                                          .password.textEditingController.text,
                                    );
                                  } else {
                                    final error = validResult.getErrors();
                                    if (error.isEmpty) return;
                                    cubitNoti.onNotification(
                                      NotificationInfo(
                                        NotificationType.error,
                                        message: error.first,
                                      ),
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
                                    '¿Ya tienes una cuenta?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 175, 174, 174),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
