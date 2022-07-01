import 'package:dio/dio.dart';
import '../../../models/feedbackmodel.dart';

Future<List<FeedbackModel>> getFeedbackFromSheet() async {
  Response response = await Dio().get("https://script.google.com/macros/s/AKfycbz9VFMvxsq39JSbLqZtpKiDPGVNFWZ6VFprvWEbUDAHiV37MFAMm3fEuZyyRlu7-duq/exec");
  List<dynamic> feedbacks = response.data as List<dynamic>;
  return feedbacks.map((json) {
    return FeedbackModel.fromJson(json);
  }).toList();
}