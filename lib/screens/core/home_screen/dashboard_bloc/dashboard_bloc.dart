import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardGetData>(_onGetData);
  }

  _onGetData(DashboardGetData event, Emitter<DashboardState> emit) {
    emit(DashboardLoading());
  }
}
