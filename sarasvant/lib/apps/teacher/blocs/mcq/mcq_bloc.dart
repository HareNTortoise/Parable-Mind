import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../models/questions/mcq.dart';
import '../../../../repositories/mcq.dart';

part 'mcq_event.dart';
part 'mcq_state.dart';


class MCQBloc extends Bloc<MCQEvent, MCQState> {
  final MCQRepository repository;

  MCQBloc(this.repository) : super(MCQInitial()) {
    on<FetchMCQs>((event, emit) async {
      emit(MCQLoading());
      try {
        final mCQs = await repository.getMCQs(event.bankId);
        emit(MCQLoaded(mCQs));
      } catch (e) {
        emit(MCQError(e.toString()));
      }
    });

    on<CreateMCQ>((event, emit) async {
      try {
        await repository.createMCQ(event.mcq);
        add(FetchMCQs(event.mcq.bankId)); // Reload MCQs
      } catch (e) {
        emit(MCQError(e.toString()));
      }
    });

    on<UpdateMCQ>((event, emit) async {
      try {
        await repository.updateMCQ(event.id, event.mcq);
        add(FetchMCQs(event.mcq.bankId)); // Reload MCQs
      } catch (e) {
        emit(MCQError(e.toString()));
      }
    });

    on<DeleteMCQ>((event, emit) async {
      try {
        await repository.deleteMCQ(event.id);
        add(FetchMCQs(event.id)); // Reload MCQs
      } catch (e) {
        emit(MCQError(e.toString()));
      }
    });
  }
}
