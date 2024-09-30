import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/notify_dialog_handler/cubit/notify_dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: BlocContext<SignUpCubit, SignUpState>(
        builder: (context, cubit) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                                isPassword: true,
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
                              const Spacer(),
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
