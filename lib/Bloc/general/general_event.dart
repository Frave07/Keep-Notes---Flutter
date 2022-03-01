part of 'general_bloc.dart';

abstract class GeneralEvent extends Equatable {
  const GeneralEvent();

  @override
  List<Object> get props => [];
}

class IsScrollTopAppBarEvent extends GeneralEvent {
  final bool isScroll;
  const IsScrollTopAppBarEvent(this.isScroll);
}

