import 'package:spend_analytics/shared/models/transaction_model.dart';

enum ConflictResolution { localWins, remoteWins, tie }

class ConflictResolver {
  const ConflictResolver();

  DateTime pickLatest(DateTime local, DateTime remote) {
    return local.isAfter(remote) ? local : remote;
  }

  ConflictResolution resolve({
    required DateTime localUpdatedAt,
    required DateTime remoteUpdatedAt,
  }) {
    if (localUpdatedAt.isAfter(remoteUpdatedAt)) {
      return ConflictResolution.localWins;
    }
    if (remoteUpdatedAt.isAfter(localUpdatedAt)) {
      return ConflictResolution.remoteWins;
    }
    return ConflictResolution.tie;
  }

  bool shouldApplyRemote({
    required DateTime localUpdatedAt,
    required DateTime remoteUpdatedAt,
  }) {
    return resolve(
          localUpdatedAt: localUpdatedAt,
          remoteUpdatedAt: remoteUpdatedAt,
        ) !=
        ConflictResolution.localWins;
  }

  TransactionModel reconcile({
    required TransactionModel local,
    required TransactionModel remote,
  }) {
    final outcome = resolve(
      localUpdatedAt: local.updatedAt,
      remoteUpdatedAt: remote.updatedAt,
    );
    switch (outcome) {
      case ConflictResolution.remoteWins:
        return remote;
      case ConflictResolution.localWins:
      case ConflictResolution.tie:
        return local;
    }
  }
}
