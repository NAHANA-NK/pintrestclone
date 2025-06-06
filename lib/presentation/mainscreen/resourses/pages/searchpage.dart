import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrestt/presentation/mainscreen/mainscreen_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainscreenCubit, MainscreenState>(
      builder: (context, state) {
        final cubit = context.read<MainscreenCubit>();
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                        Expanded(
                          child: TextField(

                            controller: cubit.searchController,
                            style: const TextStyle(color: Colors.white),
                            onSubmitted: (value) {
                              cubit.getSearchImage();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search Pinterest',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Optional: Add camera functionality
                          },
                          icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MasonryGridView.count(
                    controller: cubit.scrollController,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: cubit.searchimageData.length,
                    itemBuilder: (context, index) {
                      final imageurl= cubit.searchimageData[index]['URL']as String;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          child: Image.network(imageurl),
                        ),
                      );

                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
