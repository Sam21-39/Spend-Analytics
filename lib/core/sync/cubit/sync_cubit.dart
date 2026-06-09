import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'sync_state.dart';

@lazySingleton
class SyncCubit extends Cubit<SyncState> {
  SyncCubit() : super(const SyncState.idle());

  void startSync() => emit(const SyncState.syncing());

  void syncComplete({int pendingCount = 0}) =>
      emit(SyncState.synced(pendingCount: pendingCount));

  void resetToIdle() => emit(const SyncState.idle());
}
