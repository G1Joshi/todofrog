part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {
  const LoadingEvent();
}

class GetStatus extends LoadingEvent {
  const GetStatus();
}
