import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/company/cubit/company_cubit.dart';

class CompanyBody extends StatelessWidget {
  const CompanyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitCompany = context.read<CompanyCubit>();
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: const Color.fromARGB(255, 43, 44, 42),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registra una compañia',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Registro de nuevas compañias. Asegura el cumplimiento de normas y facilita la gestion',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FieldCustom(
                    controller: ControllerField(),
                    validator: (p0) {
                      return null;
                    },
                    label: 'Descripción',
                    isLabelTitle: true,
                    onChanged: (c) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonCustom(
                    onPressed: cubitCompany.saveCompany,
                    text: 'Registrar',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}//rgba(43,44,42,255)
