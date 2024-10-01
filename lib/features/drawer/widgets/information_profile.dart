/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationProfile extends StatelessWidget {
  const InformationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        final session = state.session;
        final shift = homeBloc.state.shift;

        return InkWell(
          onTap: () {
            context.push(
              ProfilePage.route(session, shift),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.width(.5),
                    child: Text(
                      session.userName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    session.employeeType,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.white.withOpacity(0.7),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/