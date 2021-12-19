part of 'publication_bloc.dart';

abstract class PublicationEvent extends Equatable {}

class FetchPublication extends PublicationEvent{
  @override
  List<Object> get props => [];
}