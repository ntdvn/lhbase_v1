import 'package:lhbase_v1/expansion_package/media_manager/ui/pages/media_resource_page.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaDelegate {
  final RequestType requestType;
  final MediaSelectType selectType;
  final int numbers;

  MediaDelegate(
      {required this.requestType, required this.selectType, this.numbers = 1});
}
