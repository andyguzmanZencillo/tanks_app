import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/helpers/dialog_handler/bloc/dialog_handler_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/create_update/cubit/upsert_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/create_update/views/create_update_sales_center_inherited.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertSalesCenterPage extends StatelessWidget {
  const UpsertSalesCenterPage({
    required this.typeOperation,
    this.salesCenterEntity = const SalesCenterEntity.empty(),
    super.key,
  });
  final TypeOperation typeOperation;
  final SalesCenterEntity salesCenterEntity;

  static Route<bool?> route({
    required TypeOperation typeOperation,
    SalesCenterEntity salesCenterEntity = const SalesCenterEntity.empty(),
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => UpsertSalesCenterPage(
        typeOperation: typeOperation,
        salesCenterEntity: salesCenterEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CreateUpdateSalesCenterInherited(
      typeOperation: typeOperation,
      salesCenterEntity: salesCenterEntity,
      child: BlocProvider(
        create: (context) => sl<UpsertSalesCenterCubit>(),
        child: const CreateUpdateSalesCenterView(),
      ),
    );
  }
}

class CreateUpdateSalesCenterView extends StatelessWidget {
  const CreateUpdateSalesCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerBloc>();
    final inherited = CreateUpdateSalesCenterInherited.of(context);
    return BlocListener<UpsertSalesCenterCubit, UpsertSalesCenterState>(
      listener: (context, state) {
        /*final s = state.createUpdateStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            dialog.onOpenNotification(
              message: 'Creando centro de venta...',
              dialogType: DialogType.loading,
            );
          } else {
            dialog.onOpenNotification(
              message: 'Actualizando Centro de venta...',
              dialogType: DialogType.loading,
            );
          }
        } else if (s == UpsertStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? 'Error al crear centro de venta'
                  : 'Error al actualizar centro de venta',
              title: 'Error',
              onPressed: () {
                context.pop();
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.error,
          );
        } else if (s == UpsertStatus.success) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? 'Centro de venta creado exitosamente'
                  : 'Centro de venta actualizado exitosamente',
              title: inherited.typeOperation == TypeOperation.create
                  ? 'Creación exitosa'
                  : 'Actualización exitosa',
              onPressed: () {
                context.pop();
                Navigator.pop(context, true);
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.success,
          );
        }*/
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocContext<UpsertSalesCenterCubit, UpsertSalesCenterState>(
        builder: (context, cubit) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inherited.typeOperation == TypeOperation.create
                                ? 'Creación de un Centro de venta'
                                : 'Actualización de un Centro de venta',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
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
                                labelSingle: false,
                                controller: inherited.saleCenter,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo nombre artículo requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Centro de venta',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.description,
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
                                label: 'Descripción',
                                labelSingle: false,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.email,
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
                                label: 'Correo electronico',
                                labelSingle: false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ButtonCustom(
                                onPressed: () {
                                  final validResult = inherited.valid();
                                  if (validResult.isPassed) {
                                    if (inherited.typeOperation ==
                                        TypeOperation.create) {
                                      cubit.create(
                                        centroVenta:
                                            inherited.saleCenter.getValue(),
                                        descripcion:
                                            inherited.description.getValue(),
                                        correo: inherited.email.getValue(),
                                      );
                                    } else {
                                      cubit.updateArticle(
                                        salesCenterEntity:
                                            inherited.salesCenterEntity,
                                        centroVenta:
                                            inherited.saleCenter.getValue(),
                                        descripcion:
                                            inherited.description.getValue(),
                                        correo: inherited.email.getValue(),
                                      );
                                    }
                                  }
                                },
                                text: inherited.typeOperation ==
                                        TypeOperation.create
                                    ? 'Crear Centro de venta'
                                    : 'Actualizar Centro de venta',
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
