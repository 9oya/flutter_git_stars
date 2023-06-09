import 'package:flutter_git_stars/domain/entity/user_item_model.dart';

class SearchResponse {
  final int? totalCount;
  final bool? incompleteResults;
  final List<UserItemModel> items;

  SearchResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<UserItemModel> items = <UserItemModel>[];
    if (json['items'] != null) {
      items = List<UserItemModel>.from(
          json['items'].map((x) => UserItemModel.fromJson(x)));
    }
    return SearchResponse(
      totalCount: json['total_count'] ?? 0,
      incompleteResults: json['incomplete_results'] ?? false,
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_count': totalCount,
      'incomplete_results': incompleteResults,
      'items': items.map((x) => x.toJson()).toList(),
    };
  }
}
