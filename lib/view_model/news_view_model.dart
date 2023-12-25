import 'package:daily_read/models/headline_model.dart';
import 'package:daily_read/repository/news_repo.dart';

class NewsViewModel {
  final _repo = NewsRepo();
  Future<HeadlineModel> fetchHeadlineApi() async {
    final response = await _repo.fetchHeadlineApi();
    return response;
  }
}
