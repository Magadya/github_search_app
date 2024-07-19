import '../../data/models/pull_data_model.dart';


abstract class PullsRepository {
  Future<List<PullDataModel>?> fetchAllPulls(String owner, String name);
}
