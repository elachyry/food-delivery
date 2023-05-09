part of 'autocomplete_bloc.dart';

abstract class AutocompleteEvent extends Equatable {
  const AutocompleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAutocomplete extends AutocompleteEvent {
  final String input;

  const LoadAutocomplete({this.input = ''});

  @override
  List<Object> get props => [input];
}
