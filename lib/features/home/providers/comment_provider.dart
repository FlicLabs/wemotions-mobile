import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class CommentProvider extends ChangeNotifier {
  final comment = TextEditingController();
  final focusNode = FocusNode();
  final _service = CommentService();

  List<CommentModel> _comment_list = <CommentModel>[];
  List<CommentModel> get comment_list => _comment_list;

  set comment_list(List<CommentModel> value) {
    _comment_list = value;
  }

  List<CommentModel> _temp = <CommentModel>[];

  bool _update_count = false;
  bool get update_count => _update_count;

  set update_count(bool value) {
    _update_count = value;
  }

  bool _is_upvoted = false;
  bool get is_upvoted => _is_upvoted;

  set is_upvoted(bool value) {
    _is_upvoted = value;
    notifyListeners();
  }

  Future<void> getComments({required int id}) async {
    _comment_list.clear();
    Response response = await _service.getComments(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      String jsonString = json.encode(response.data);
      _temp = (json.decode(jsonString) as List)
          .map((data) => CommentModel.fromJson(data))
          .toList();
      _comment_list = _temp.reversed.toList();
      notifyListeners();
    } else {
      //TODO: handle error
    }
  }

  Future<void> addComment({
    required int post_id,
    required String body,
  }) async {
    Map data = {
      "body": body,
    };

    Response response = await _service.addComment(
      post_id: post_id,
      data: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      comment.clear();
      update_count = true;
      notifyListeners();
      await getComments(id: post_id);
      update_count = false;
      notifyListeners();
    } else {
      //TODO: handle error
    }
  }

  Future<void> upvoteComment({required int comment_id}) async {
    comment_list.forEach((element) {
      if (element.id == comment_id) {
        element.upvoted = true;
        element.upvoteCount = element.upvoteCount + 1;
      }
    });
    notifyListeners();
    final response = await _service.upvoteComment(comment_id);
    if (response == 200 || response == 201) {}
  }

  Future<void> removeUpvoteComment({required int comment_id}) async {
    comment_list.forEach((element) {
      if (element.id == comment_id) {
        element.upvoted = false;
        element.upvoteCount = element.upvoteCount - 1;
      }
    });
    notifyListeners();
    final response = await _service.removeUpvoteComment(comment_id);
    if (response == 200 || response == 201) {}
  }
}
