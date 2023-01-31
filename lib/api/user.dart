import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/team.dart';

Future<String> shareUserTeam(String name, List<TeamTemtem> temtems) async {
  final body = {
    'name': name,
    'temtems': temtems,
  };
  final r = await apipost('/user/team', body: body);
  return r['share_url'];
}
