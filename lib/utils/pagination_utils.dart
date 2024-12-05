import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationUtil extends GetxController {
  ScrollController? scrollController;
  bool nextPage;
  bool loading;
  final int limit;
  Rx<int>? offset;
  final Future<void> Function() fetchNextPage; // Removed offset and limit

  PaginationUtil(
      {this.nextPage = true,
      this.loading = true,
      this.limit = 20,
      this.offset,
      required this.fetchNextPage}) {
    scrollController = ScrollController();
    scrollController!.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController!.position.atEdge) {
      if (scrollController!.position.pixels != 0) {
        // You're at the bottom.
        if (!loading && nextPage) {
          fetchNextPage();
        }
      }
    }
  }

  @override
  void onClose() {
    scrollController!.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController!.dispose();
    super.dispose();
  }
}
