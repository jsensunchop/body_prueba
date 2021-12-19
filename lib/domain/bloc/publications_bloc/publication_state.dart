part of 'publication_bloc.dart';


abstract class PublicationState extends Equatable {}

class InitialPublicationState extends PublicationState{
  @override
  List<Object> get props => [];
}
// success state
class PublicationsFetched extends PublicationState {
  final List<PostResponse> posts;

  PublicationsFetched(this.posts);

  @override
  List<Object> get props => [posts];
}
//loading state
class FetchingPublications extends PublicationState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends PublicationState{
  @override
  List<Object> get props => [];
}