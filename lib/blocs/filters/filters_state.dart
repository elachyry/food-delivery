part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];
}

class FiltersLoading extends FiltersState {}

class FiltersLoaded extends FiltersState {
  final Filter filter;

  const FiltersLoaded({this.filter = const Filter()});

  @override
  List<Object> get props => [filter];
}

class FiltersError extends FiltersState {}
