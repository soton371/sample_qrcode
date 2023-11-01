import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sample_qrcode/services/submit_label_ser.dart';
import 'package:sample_qrcode/views/generate_qr/create_qr.dart';

part 'submit_label_event.dart';
part 'submit_label_state.dart';

class SubmitLabelBloc extends Bloc<SubmitLabelEvent, SubmitLabelState> {
  SubmitLabelBloc() : super(SubmitLabelInitial()) {
    on<DoSubmitLabelEvent>((event, emit) async {
      debugPrint("call DoSubmitLabelEvent");
      emit(SubmitLabelInitial());
      final submitData = await submitLabelData(event.payload);
      final listResponse = submitData.submitListResponse;
      if (submitData.statusCode != 200 ||
          (listResponse == null || listResponse.isEmpty)) {
        emit(const SubmitLabelException(msg: "Sending failed"));
        return;
      }
      emit(SubmitLabelSuccess());

      final printDone = await createPdf(submitData, event.saUser);
      if (!printDone) {
        emit(const SubmitLabelException(msg: "Print failed"));
        return;
      }
      emit(PrintingSuccess());
    });
  }
}
