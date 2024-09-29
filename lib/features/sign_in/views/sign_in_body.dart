import 'package:flutter/material.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/features/sign_up/views/sign_up_page.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    //final inherited = SignUpInherited.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromARGB(255, 230, 230, 230),
                                ),
                                child: ToggleSwitch(
                                  minWidth: double.maxFinite,
                                  minHeight: 45,
                                  inactiveBgColor:
                                      const Color.fromARGB(255, 230, 230, 230),
                                  activeBgColor: const [Colors.white],
                                  radiusStyle: true,
                                  animationDuration: 100,
                                  cornerRadius: 30,
                                  inactiveFgColor:
                                      const Color.fromARGB(255, 100, 100, 100),
                                  activeFgColor: Colors.black,
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 16,
                                    ),
                                  ],
                                  multiLineText: true,
                                  centerText: true,
                                  totalSwitches: 2,
                                  labels: const ['Login', 'Registro'],
                                  onToggle: (index) {},
                                ),
                              ),*/
                            const SizedBox(
                              height: 20,
                            ),
                            FieldAuth2(
                              icon: const Icon(Icons.factory),
                              controller: ControllerField(),
                              validator: (p0) {
                                return null;
                              },
                              onChanged: (p0) {},
                              label: 'ID compañia',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FieldAuth2(
                              icon: const Icon(Icons.person_2_rounded),
                              controller: ControllerField(),
                              validator: (p0) {
                                return null;
                              },
                              onChanged: (p0) {},
                              label: 'Usuario',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FieldAuth2(
                              icon: const Icon(Icons.security),
                              controller: ControllerField(),
                              validator: (p0) {
                                return null;
                              },
                              onChanged: (p0) {},
                              label: 'Contraseña',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonCustom(
                              onPressed: () {
                                cubit.login(
                                  userName: 'Juan P. Actualizado',
                                  password: 'nuevaclave123',
                                  idCompany: '1',
                                );
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
                                    color: Color.fromARGB(255, 175, 174, 174),
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
                                      color: Color.fromARGB(255, 255, 255, 255),
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
              ),
            ],
          );
        },
      ),
    );
  }
}
