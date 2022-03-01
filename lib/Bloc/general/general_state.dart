part of 'general_bloc.dart';

class GeneralState extends Equatable {


  final bool isScrollAppBar;

  const GeneralState({
    this.isScrollAppBar = false,
  });

  GeneralState copyWith({
    bool? isScrollAppBar,
  }) => GeneralState(
    isScrollAppBar: isScrollAppBar ?? this.isScrollAppBar
  );
  
  @override
  List<Object> get props => [
    isScrollAppBar,
  ];

}

