import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../resources/model.dart';


part 'mainscreen_state.dart';

class MainscreenCubit extends Cubit<MainscreenState> {
  MainscreenCubit() : super(MainscreenInitial()){
    getimage();
    print("function called");
  }

  int navigationPage = 1;

  List<Map<String,dynamic>>imageData=[];
  List<Map<String,dynamic>>searchimageData=[];
  bool _scrollListenerAdded = false;
  bool get isScrollListenerAdded => _scrollListenerAdded;
  final scrollController = ScrollController();
 bool isPaginationLoading = false;
 int currentPage = 1;
final searchController = TextEditingController();




  void changePage(int pageNumber) {
    print("Function called");
    navigationPage = pageNumber;
    print("Current page: $navigationPage");
    emit(ScreenChanged(pageNumber));
  }


  void getimage ({loadMore=false}) async {
    if (loadMore) {
      print("loadmoretrure");
      if (isPaginationLoading) return;
      isPaginationLoading = true;
      emit(ImageLoading());
      currentPage++;
    }

    print("get image called");

    final String url= "https://api.pexels.com/v1/curated?page=$currentPage&per_page=20";
   const apikey = "OGPIArUbNPcg93N0gnl0sRuJtZItmlmiTByVuaCjCeRyQUvqU2guKo9I";

   final response = await http.get(Uri.parse(url),headers:{"Authorization":apikey} );
  if (response.statusCode == 200){
    print("success");
    final data = imageModelFromJson(response.body);

    final newData = data.photos.map((photo){
      return {
        "ID" : photo.id,
        "URL": photo.src.original
      };
      }
  ).toList();
    if (loadMore) {
      print("added");
      imageData.addAll(newData);
    } else {
      imageData = newData;
    }
    isPaginationLoading = false;
    emit(imageLoaded());
  } else {
    isPaginationLoading = false;
  }


  }
  void getSearchImage ({loadMore=false}) async {
    print("function called");
    if (loadMore) {
      print("loadmoretrure");
      if (isPaginationLoading) return;

      isPaginationLoading = true;
      emit(searchimageLoading());
      currentPage++;
    }

    print("get image called");
final String query = searchController.text;
    final String url= "https://api.pexels.com/v1/search?query=$query&page=1&per_page=20";
    const apikey = "OGPIArUbNPcg93N0gnl0sRuJtZItmlmiTByVuaCjCeRyQUvqU2guKo9I";
    final response = await http.get(Uri.parse(url),headers:{"Authorization":apikey} );
    if (response.statusCode == 200){
      print("success");
      final searchdata = imageModelFromJson(response.body);

      final newsearchData = searchdata.photos.map((photo){
        return {
          "ID" : photo.id,
          "URL": photo.src.original
        };
      }
      ).toList();
      if (loadMore) {
        print("added");
        searchimageData.addAll(newsearchData);
      } else {
        searchimageData = newsearchData;
      }
      isPaginationLoading = false;
      emit(searchimageLoaded());
    } else {
      isPaginationLoading = false;
    }


  }











































  void setupScrollListener() {
    print("scrollcalled");
    if (_scrollListenerAdded) return;
    print("addmorecalled");
    _scrollListenerAdded = true;

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        if (!isPaginationLoading) {
          getimage(loadMore: true);
        }
      }
    });
  }
}

