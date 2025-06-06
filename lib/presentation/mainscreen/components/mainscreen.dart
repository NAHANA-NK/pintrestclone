import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintrestt/presentation/mainscreen/mainscreen_cubit.dart';
import 'package:pintrestt/presentation/mainscreen/resourses/pages/homescreen.dart';
import 'package:pintrestt/presentation/mainscreen/resourses/pages/searchpage.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainscreenCubit(),
      child: BlocBuilder<MainscreenCubit, MainscreenState>(
        builder: (context, state) {
          final cubit = context.read<MainscreenCubit>();
          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: Container(
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        cubit.changePage(1); // Home
                      },
                      icon: Icon(Icons.home, color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.changePage(2); // Search
                      },
                      icon: Icon(Icons.search_rounded, color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.changePage(3); // Add
                      },
                      icon: Icon(Icons.add, color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.changePage(4); // Comments
                      },
                      icon: Icon(Icons.comment, color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.changePage(5); // Profile
                      },
                      icon: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
              body: state is ScreenChanged
                  ? _getPage(state.pageIndex)
                  : homescreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 1:
        return homescreen();
      case 2:
        return SearchPage();
    // Add cases for index 3, 4, 5 as you implement those screens
      default:
        return Center(child: Text("Page not found"));
    }
  }
}
