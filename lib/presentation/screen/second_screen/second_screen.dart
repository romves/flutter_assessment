import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/router/route_path.dart';
import 'package:flutter_assessment/domain/entity/user.dart';
import 'package:flutter_assessment/presentation/screen/second_screen/bloc/second_screen_bloc.dart';
import 'package:flutter_assessment/presentation/widget/button.dart';
import 'package:flutter_assessment/presentation/widget/scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondScreen extends StatelessWidget {
  final String? name;
  const SecondScreen({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Second Screen',
      body: BlocProvider(
        create: (_) =>
            SecondScreenBloc()..add(SecondScreenInitialized(name: name ?? "")),
        child: const SecondScreenContent(),
      ),
    );
  }
}

class SecondScreenContent extends StatelessWidget {
  const SecondScreenContent({super.key});

  Future<void> _handleUserSelection(BuildContext context) async {
    final navigator = GoRouter.of(context);
    final blocContext = context.read<SecondScreenBloc>();

    try {
      final selectedUser =
          await navigator.push<UserEntity>(AppRoutePath.usersList);

      if (!context.mounted) return;

      if (selectedUser != null) {
        blocContext.add(
          UserSelected(user: selectedUser),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to select user: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: GoogleFonts.poppins(
              fontSize: 12,
            ),
          ),
          BlocBuilder<SecondScreenBloc, SecondScreenState>(
            builder: (context, state) {
              if (state.name != null) {
                return Text(
                  state.name ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }

              return Container();
            },
          ),
          Expanded(
            child: Center(
              child: BlocBuilder<SecondScreenBloc, SecondScreenState>(
                builder: (context, state) {
                  if (state.user != null) {
                    return Text(
                      "${state.user?.firstName} ${state.user?.lastName}",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }

                  return Text(
                    "Selected User Name",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ),
          CustomButton(
            text: "Choose a User",
            onPressed: () => _handleUserSelection(context),
          )
        ],
      ),
    );
  }
}
