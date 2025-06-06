import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../mainscreen_cubit.dart';

class homescreen extends StatelessWidget {
  const homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainscreenCubit, MainscreenState>(
        builder: (context, state) {
          final cubit = context.read<MainscreenCubit>();
          if (!cubit.isScrollListenerAdded){
            cubit.setupScrollListener();
          }

          return Column(
            children: [
              Expanded(
                child: MasonryGridView.count(
                  controller: cubit.scrollController,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: cubit.imageData.length,
                  itemBuilder: (context, index) {
                    final imageurl= cubit.imageData[index]['URL']as String;
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
          );
        },
      ),
    );
  }
}
