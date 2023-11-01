part of 'submit_label_bloc.dart';

sealed class SubmitLabelState extends Equatable {
  const SubmitLabelState();

  @override
  List<Object> get props => [];
}

final class SubmitLabelInitial extends SubmitLabelState {} //Sending

final class SubmitLabelSuccess extends SubmitLabelState {}

final class PrintingSuccess extends SubmitLabelState {
}

final class SubmitLabelException extends SubmitLabelState {
  final String msg;
  const SubmitLabelException({required this.msg});
  @override
  List<Object> get props => [msg];
}
