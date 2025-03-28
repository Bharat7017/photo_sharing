abstract class ImagePostEvent {}

class ImagePickedEvent extends ImagePostEvent {
  final String imagePath;

  ImagePickedEvent(this.imagePath);
}

class FilterChangedEvent extends ImagePostEvent {
  final double strength;
  FilterChangedEvent(this.strength);
}

class PostTypeChangedEvent extends ImagePostEvent {
  final String postType;
  PostTypeChangedEvent(this.postType);
}

class PostCreatedEvent extends ImagePostEvent {}
