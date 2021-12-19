import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';


part 'publication_event.dart';

part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  PublicationBloc(this.userRepo) : super(InitialPublicationState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<PublicationEvent, PublicationState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<PublicationState> mapEventToState(PublicationEvent event) async* {
    if (event is FetchPublication) {
      yield FetchingPublications();
      try {
        //consuming api
        final data = await userRepo.fetchPosts();
        //database successfully fetched
        yield PublicationsFetched(data);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
      }
    }
  }

  PublicationState get initialState => InitialPublicationState();
}
