import 'package:flutter/material.dart';
import 'package:flutter_assessment/presentation/screen/first_screen/cubit/first_screen_cubit.dart';
import 'package:flutter_assessment/presentation/widget/avatar.dart';
import 'package:flutter_assessment/presentation/widget/button.dart';
import 'package:flutter_assessment/presentation/widget/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => FirstScreenCubit(),
        child: BlocListener<FirstScreenCubit, FirstScreenState>(
          listener: (context, state) {
            if (state.showDialog) {
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<FirstScreenCubit>(),
                    child: AlertDialog(
                      title: Text("Palindrome Checker"),
                      content: Text(state.isPalindrome
                          ? 'isPalindrome'
                          : 'Not Palindrome'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.read<FirstScreenCubit>().closeDialog();
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
          child: Scaffold(
            body: _buildBody(context),
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AvatarWidget(),
                  const SizedBox(height: 64),
                  _buildNameField(context),
                  const SizedBox(height: 24),
                  _buildPalindromeField(context),
                  const SizedBox(height: 42),
                  _buildCheckButton(context),
                  const SizedBox(height: 14),
                  _buildNextButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return BlocBuilder<FirstScreenCubit, FirstScreenState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextField(
          hintText: 'Name',
          errorText: state.name.isEmpty ? 'Name is empty' : null,
          onChanged: (value) {
            context.read<FirstScreenCubit>().setName(value);
          },
        );
      },
    );
  }

  Widget _buildPalindromeField(BuildContext context) {
    return BlocBuilder<FirstScreenCubit, FirstScreenState>(
      buildWhen: (previous, current) =>
          previous.palindrome != current.palindrome,
      builder: (context, state) {
        return CustomTextField(
          hintText: 'Palindrome',
          errorText: state.palindrome.isEmpty ? 'Palindrome is empty' : null,
          onChanged: (value) {
            context.read<FirstScreenCubit>().setPalindrome(value);
          },
        );
      },
    );
  }

  Widget _buildCheckButton(BuildContext context) {
    return BlocBuilder<FirstScreenCubit, FirstScreenState>(
      builder: (context, state) {
        return CustomButton(
          text: 'CHECK',
          onPressed: () {
            if (state.palindrome.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Please enter a sentence!'),
                ),
              );
              return;
            }
            context.read<FirstScreenCubit>().checkPalindrome();
          },
        );
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return BlocBuilder<FirstScreenCubit, FirstScreenState>(
      builder: (context, state) {
        return CustomButton(
          text: 'NEXT',
          onPressed: () {
            if (state.name.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Please enter your name!'),
                ),
              );
              return;
            }
            GoRouter.of(context).push('/users/${state.name}', extra: {
              'name': state.name,
            });
          },
        );
      },
    );
  }
}
