part of 'submit_label_bloc.dart';

sealed class SubmitLabelEvent extends Equatable {
  const SubmitLabelEvent();

  @override
  List<Object> get props => [];
}

class DoSubmitLabelEvent extends SubmitLabelEvent {
  final Map<String, Object> payload;
  final String saUser;
  const DoSubmitLabelEvent({required this.payload, required this.saUser});

  @override
  List<Object> get props => [payload,saUser];
}