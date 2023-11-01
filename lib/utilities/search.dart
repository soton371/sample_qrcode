import 'package:sample_qrcode/models/search_label_mod.dart';

List<ListResponse> searchData(
    List<ListResponse> listResponse, String query) {
  return listResponse.where((response) {
    return response.allocationInfo?.toLowerCase().contains(query.toLowerCase()) ?? false;
  }).toList();
}