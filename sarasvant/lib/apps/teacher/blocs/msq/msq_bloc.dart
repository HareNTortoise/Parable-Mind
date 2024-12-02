import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../models/questions/msq.dart';
import '../../../../repositories/msq.dart';

part 'msq_event.dart';
part 'msq_state.dart';



class MSQBloc extends Bloc<MSQEvent, MSQState> {
  final MSQRepository repository;

  MSQBloc(this.repository) : super(MSQInitial()) {
    on<FetchMSQs>((event, emit) async {
      emit(MSQLoading());
      try {
        final mSQs = await repository.getMSQs(event.bankId);
        emit(MSQLoaded(mSQs));
      } catch (e) {
        emit(MSQError(e.toString()));
      }
    });

    on<CreateMSQ>((event, emit) async {
      try {
        await repository.createMSQ(event.msq);
        add(FetchMSQs(event.msq.bankId));
      } catch (e) {
        emit(MSQError(e.toString()));
      }
    });

    on<UpdateMSQ>((event, emit) async {
      try {
        await repository.updateMSQ(event.id, event.msq);
        add(FetchMSQs(event.msq.bankId));
      } catch (e) {
        emit(MSQError(e.toString()));
      }
    });

    on<DeleteMSQ>((event, emit) async {
      try {
        await repository.deleteMSQ(event.id);
        add(FetchMSQs(event.id));
      } catch (e) {
        emit(MSQError(e.toString()));
      }
    });
  }
}
