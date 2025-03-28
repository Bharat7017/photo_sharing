import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_post_event.dart';
import 'image_post_state.dart';

class ImagePostBloc extends Bloc<ImagePostEvent, ImagePostState> {
  ImagePostBloc() : super(ImagePostInitialState());

  Stream<ImagePostState> mapEventToState(ImagePostEvent event) async* {
    if (event is ImagePickedEvent) {
      yield* _mapImagePickedEventToState(event);
    } else if (event is FilterChangedEvent) {
      yield* _mapFilterChangedEventToState(event);
    } else if (event is PostTypeChangedEvent) {
      yield* _mapPostTypeChangedEventToState(event);
    } else if (event is PostCreatedEvent) {
      yield* _mapPostCreatedEventToState();
    }
  }

  Stream<ImagePostState> _mapImagePickedEventToState(
    ImagePickedEvent event,
  ) async* {
    yield ImagePostLoadingState();
    try {
      yield ImagePostSuccessState(
        imagePath: event.imagePath,
        postType: 'post',
        filterStrength: 1.0,
      );
    } catch (e) {
      yield ImagePostErrorState('Failed to pick image: $e');
    }
  }

  Stream<ImagePostState> _mapFilterChangedEventToState(
    FilterChangedEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ImagePostSuccessState) {
      yield ImagePostSuccessState(
        imagePath: currentState.imagePath,
        postType: currentState.postType,
        filterStrength: event.strength,
      );
    }
  }

  Stream<ImagePostState> _mapPostTypeChangedEventToState(
    PostTypeChangedEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ImagePostSuccessState) {
      yield ImagePostSuccessState(
        imagePath: currentState.imagePath,
        postType: event.postType,
        filterStrength: currentState.filterStrength,
      );
    }
  }

  Stream<ImagePostState> _mapPostCreatedEventToState() async* {
    yield ImagePostSuccessState(
      imagePath: '',
      postType: '',
      filterStrength: 1.0,
    );
  }
}
