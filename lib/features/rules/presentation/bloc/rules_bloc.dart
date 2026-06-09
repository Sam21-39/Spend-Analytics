import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/rules/domain/usecases/create_rule_use_case.dart';
import 'package:spend_analytics/features/rules/domain/usecases/delete_rule_use_case.dart';
import 'package:spend_analytics/features/rules/domain/usecases/evaluate_rules_use_case.dart';
import 'package:spend_analytics/features/rules/domain/usecases/load_rules_use_case.dart';
import 'package:spend_analytics/features/rules/domain/usecases/toggle_rule_use_case.dart';
import 'package:spend_analytics/features/rules/domain/usecases/update_rule_use_case.dart';

import 'rules_event.dart';
import 'rules_state.dart';

@injectable
class RulesBloc extends Bloc<RulesEvent, RulesState> {
  RulesBloc(
    this._loadRules,
    this._createRule,
    this._updateRule,
    this._deleteRule,
    this._toggleRule,
    this._evaluateRules,
  ) : super(const RulesState.initial()) {
    on<RulesLoad>(_onLoad);
    on<RulesCreate>(_onCreate);
    on<RulesUpdate>(_onUpdate);
    on<RulesDelete>(_onDelete);
    on<RulesToggle>(_onToggle);
    on<RulesEvaluate>(_onEvaluate);
  }

  final LoadRulesUseCase _loadRules;
  final CreateRuleUseCase _createRule;
  final UpdateRuleUseCase _updateRule;
  final DeleteRuleUseCase _deleteRule;
  final ToggleRuleUseCase _toggleRule;
  final EvaluateRulesUseCase _evaluateRules;

  Future<void> _onLoad(RulesLoad event, Emitter<RulesState> emit) async {
    emit(const RulesState.loading());
    final result = await _loadRules(event.userId);
    result.fold(
      (f) => emit(RulesState.failure(failure: f)),
      (rules) => emit(RulesState.loaded(rules: rules)),
    );
  }

  Future<void> _onCreate(RulesCreate event, Emitter<RulesState> emit) async {
    emit(const RulesState.saving());
    final result = await _createRule(event.rule);
    result.fold(
      (f) => emit(RulesState.failure(failure: f)),
      (_) => add(RulesEvent.load(userId: event.rule.userId)),
    );
  }

  Future<void> _onUpdate(RulesUpdate event, Emitter<RulesState> emit) async {
    emit(const RulesState.saving());
    final result = await _updateRule(event.rule);
    result.fold(
      (f) => emit(RulesState.failure(failure: f)),
      (_) => add(RulesEvent.load(userId: event.rule.userId)),
    );
  }

  Future<void> _onDelete(RulesDelete event, Emitter<RulesState> emit) async {
    final result = await _deleteRule(id: event.id, userId: event.userId);
    result.fold(
      (f) => emit(RulesState.failure(failure: f)),
      (_) => add(RulesEvent.load(userId: event.userId)),
    );
  }

  Future<void> _onToggle(RulesToggle event, Emitter<RulesState> emit) async {
    final result = await _toggleRule(
      id: event.id,
      userId: event.userId,
      isActive: event.isActive,
    );
    result.fold(
      (f) => emit(RulesState.failure(failure: f)),
      (_) => add(RulesEvent.load(userId: event.userId)),
    );
  }

  Future<void> _onEvaluate(
      RulesEvaluate event, Emitter<RulesState> emit) async {
    // Evaluation results (fired notifications) are logged; state unchanged
    await _evaluateRules(event.expense);
  }
}
