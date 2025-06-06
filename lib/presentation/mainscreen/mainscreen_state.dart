part of 'mainscreen_cubit.dart';

@immutable
sealed class MainscreenState {}

final class MainscreenInitial extends MainscreenState {

}
final class ScreenChanged extends MainscreenState{
  final int pageIndex;
  ScreenChanged(this.pageIndex);

}

final class imageLoaded extends MainscreenState {}
final class ImageLoading extends MainscreenState {}
final class searchimageLoaded extends MainscreenState {}
final class searchimageLoading extends MainscreenState {}
