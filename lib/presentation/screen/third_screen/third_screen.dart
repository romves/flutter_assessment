import 'package:flutter/material.dart';
import 'package:flutter_assessment/data/datasource/remote/user_service.dart';
import 'package:flutter_assessment/data/repository/user_repo_impl.dart';
import 'package:flutter_assessment/domain/usecase/get_list_user.dart';
import 'package:flutter_assessment/presentation/screen/third_screen/bloc/third_screen_bloc.dart';
import 'package:flutter_assessment/presentation/widget/scaffold.dart';
import 'package:flutter_assessment/presentation/widget/user_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Third Screen',
      body: BlocProvider(
        create: (_) => ThirdScreenBloc(
          getListUserUseCase: GetListUserUseCase(
            userRepository: UserRepoImpl(
              remoteDataSource: UserService(),
            ),
          ),
        )..add(UserFetched()),
        child: const ThirdScreenContent(),
      ),
    );
  }
}

class ThirdScreenContent extends StatefulWidget {
  const ThirdScreenContent({super.key});

  @override
  ThirdScreenContentState createState() => ThirdScreenContentState();
}

class ThirdScreenContentState extends State<ThirdScreenContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ThirdScreenBloc>().add(UserFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdScreenBloc, ThirdScreenState>(
      builder: (context, state) {
        if (state is ThirdScreenLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
            ),
          );
        }

        if (state is ThirdScreenError) {
          return Center(
            child: Text(
              state.message,
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          );
        }

        if (state is ThirdScreenLoaded) {
          if (state.users.isEmpty) {
            return const Center(
              child: Text('No users found.'),
            );
          }

          return RefreshIndicator(
            color: Colors.blueGrey,
            onRefresh: () async {
              context.read<ThirdScreenBloc>().add(UserRefresh());
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.users.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Loading more users...',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final user = state.users[index];
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).pop(user);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: UserCard(user: user),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.withAlpha(50),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
