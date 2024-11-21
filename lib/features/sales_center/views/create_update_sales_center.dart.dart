import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/helpers/create_update_sales_center_inherited.dart';
import 'package:tanks_app/features/sales_center/helpers/extend_fields_sale_center.dart';

class UpsertSalesCenterPage extends StatelessWidget {
  const UpsertSalesCenterPage({
    required this.typeOperation,
    super.key,
  });
  final TypeOperation typeOperation;

  @override
  Widget build(BuildContext context) {
    return CreateUpdateSalesCenterInherited(
      typeOperation: typeOperation,
      child: const CreateUpdateSalesCenterView(),
    );
  }
}

class CreateUpdateSalesCenterView extends StatelessWidget {
  const CreateUpdateSalesCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = CreateUpdateSalesCenterInherited.of(context);
    final salesCenterCubit = context.read<SalesCenterCubit>();
    return FullWidgetGeneric(
      onInit: () {
        if (inherited.typeOperation == TypeOperation.update) {
          inherited.setData(salesCenterCubit.state.selected);
        }
      },
      child: const CreateUpdateSalesCenterBody(),
    );
  }
}

class CreateUpdateSalesCenterBody extends StatelessWidget {
  const CreateUpdateSalesCenterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = CreateUpdateSalesCenterInherited.of(context);
    final salesCenterCubit = context.read<SalesCenterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          inherited.typeOperation == TypeOperation.create
              ? 'Nuevo Centro de venta'
              : 'Modificar Centro de venta',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 16, 16, 34),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: inherited.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldPro(
                      controller: inherited.saleCenter,
                      extendTextField: ExtendFieldsSaleCenter.saleCenter,
                    ),
                    TextFieldPro(
                      controller: inherited.description,
                      extendTextField: ExtendFieldsSaleCenter.description,
                    ),
                    TextFieldPro(
                      controller: inherited.email,
                      extendTextField: ExtendFieldsSaleCenter.email,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonCustom(
                            backgroundColor: Colors.red,
                            onPressed: () {
                              context.pop();
                            },
                            text: 'Cancelar',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonCustom(
                            onPressed: () {
                              final validResult = inherited.valid();
                              if (validResult.isPassed) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (inherited.typeOperation ==
                                    TypeOperation.create) {
                                  salesCenterCubit.create(
                                    centroVenta:
                                        inherited.saleCenter.getValue(),
                                    descripcion:
                                        inherited.description.getValue(),
                                    correo: inherited.email.getValue(),
                                  );
                                } else {
                                  salesCenterCubit.updateArticle(
                                    salesCenterEntity:
                                        salesCenterCubit.state.selected,
                                    centroVenta:
                                        inherited.saleCenter.getValue(),
                                    descripcion:
                                        inherited.description.getValue(),
                                    correo: inherited.email.getValue(),
                                  );
                                }
                              }
                            },
                            text:
                                inherited.typeOperation == TypeOperation.create
                                    ? 'Registrar'
                                    : 'Actualizar',
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
    );
  }
}
