part of 'ai_explanation_cubit.dart';

abstract class AiExplanationState {}

class AiExplanationInitial extends AiExplanationState {}

class AiExplanationLoading extends AiExplanationState {}

class AiExplanationLoaded extends AiExplanationState {
  final String explanation;
  AiExplanationLoaded(this.explanation);
}

class AiExplanationError extends AiExplanationState {
  final String message;
  AiExplanationError(this.message);
}
