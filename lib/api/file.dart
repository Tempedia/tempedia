import 'package:tempedia/api/api.dart';

String fileurl(String fileid) {
  final uri = apiuri("/files/$fileid");
  return uri.toString();
}
