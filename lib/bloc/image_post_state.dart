abstract class ImagePostState {}

class ImagePostInitialState extends ImagePostState {}

class ImagePostLoadingState extends ImagePostState {}

class ImagePostSuccessState extends ImagePostState {
  final String imagePath;
  final String postType;
  final double filterStrength;

  ImagePostSuccessState({
    required this.imagePath,
    required this.postType,
    required this.filterStrength,
  });
}

class ImagePostErrorState extends ImagePostState {
  final String error;
  ImagePostErrorState(this.error);
}
