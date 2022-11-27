import 'package:quiz_us/data/api/remote_api.dart';
import 'package:quiz_us/data/models/request/question_request.dart';
import 'package:quiz_us/domain/entities/question.dart';
import 'package:quiz_us/domain/repositories/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
    (ref) => QuizRepositoryImpl(ref.read(remoteApiProvider)));

class QuizRepositoryImpl extends QuizRepository {
  final RemoteApi _remoteApi;

  QuizRepositoryImpl(this._remoteApi);

  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId}) {
    return _remoteApi
        .getQuestions(QuestionRequest(
            type: 'multiple', amount: numQuestions, category: categoryId))
        .then((value) => value
            .map((uneQuestionResponse) => uneQuestionResponse.toEntity())
            .toList());
  }
}
