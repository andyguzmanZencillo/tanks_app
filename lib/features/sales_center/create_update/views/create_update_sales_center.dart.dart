import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sales_center/create_update/cubit/upsert_sales_center_cubit.dart';
import 'package:tanks_app/features/sales_center/create_update/helpers/upsert_sales_center_listener.dart';
import 'package:tanks_app/features/sales_center/create_update/views/create_update_sales_center_inherited.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

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
    final inherited = CreateUpdateSalesCenterInherited.of(context);
    final salesCenterCubit = context.read<SalesCenterCubit>();
    return MultiBlocListener(
      listeners: [
        UpsertSalesCenterListener.upserSalesCenter(
          onTap: (p0) {
            if (p0 == UpsertStatus.success) {
              context.read<SalesCenterCubit>().getAll();
            }
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          if (inherited.typeOperation == TypeOperation.update) {
            inherited.setData(salesCenterCubit.state.selected);
          }
        },
        onDispose: () {},
        child: const CreateUpdateSalesCenterBody(),
      ),
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
                        child: Form(
                          key: inherited.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldCustomPro(
                                controller: inherited.saleCenter,
                                label: 'Centro de venta',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.description,
                                label: 'Descripción',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.email,
                                label: 'Correo electronico',
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
