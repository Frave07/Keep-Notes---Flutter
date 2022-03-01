import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {


  GeneralBloc() : super(GeneralState()) {

    on<IsScrollTopAppBarEvent>(_isScrollTopAppBar);

  }


  Future<void> _isScrollTopAppBar(IsScrollTopAppBarEvent event, Emitter<GeneralState> emit) async {

    emit(state.copyWith(isScrollAppBar: event.isScroll));

  }


  

}
