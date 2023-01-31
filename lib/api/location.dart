import 'package:tempedia/api/api.dart';
import 'package:tempedia/models/location.dart';

Future<ApiList> findTemtemLocations(
    {String query = '', int page = 1, int pageSize = 99}) async {
  final data = await apiget(
    '/temtem/locations',
    queryParams: {'query': query, 'page': '$page', 'pageSize': '$pageSize'},
  );

  return ApiList.fromJson(data, TemtemLocation.fromJson);
}

Future<List<TemtemLocationArea>> findTemtemLocationAreasByLocation(
    String location) async {
  final data = await apiget('/temtem/location/$location/areas');
  return (data as List).map((e) => TemtemLocationArea.fromJson(e)).toList();
}

Future<List<TemtemLocation>> findTemtemLocationsByTemtem(String name) async {
  final data = await apiget('/temtem/temtem/$name/locations');
  return (data as List).map((e) => TemtemLocation.fromJson(e)).toList();
}
