/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/app/bloc/app_bloc.dart';

class InformationVersion extends StatelessWidget {
  const InformationVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.packageInfo?.appName ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const Text(
              'Powered by Zencillo',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Versión: ${state.packageInfo?.version ?? '1.0.0'}.24092024',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
*/