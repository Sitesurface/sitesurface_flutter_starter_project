import 'package:flutter/material.dart';
import '../../util/asset_helper/asset_helper.dart';

import '../../constants/assets/asset_constants.dart';

class PaginatedListViewController {
  PaginatedListViewState state;
  int page;
  PaginatedListViewController({
    this.state = PaginatedListViewState.initial,
    this.page = 1,
  });
}

enum PaginatedListViewState {
  initial,
  loading,
  loaded,
}

class PaginatedListView<T> extends StatefulWidget {
  final Widget? noData;
  final int count;
  final PaginatedListViewController controller;
  final Future<void> Function(int page) getData;
  final Widget Function(BuildContext, int, void Function() refresh) itemBuilder;
  final int? totalPage;
  final int crossAxisCount;
  const PaginatedListView(
      {super.key,
      this.noData,
      required this.getData,
      required this.controller,
      this.totalPage,
      required this.count,
      required this.itemBuilder,
      required this.crossAxisCount});

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final ValueNotifier<bool> _showLoading = ValueNotifier(false);
  final _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.controller.state == PaginatedListViewState.initial) {
      _getData().then((_) {});
    }
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        widget.controller.page += 1;
        _showLoading.value = true;
        await _getData();
        _showLoading.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.state == PaginatedListViewState.loading &&
        widget.count == 0) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (widget.controller.state == PaginatedListViewState.loaded &&
        widget.count == 0) {
      return widget.noData ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AssetHelper(image: AssetConstants.iconEmptyData),
              const SizedBox(
                height: 10,
              ),
              Text(
                "No results found !!!",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "Sorry, we couldn't find any results at the moment.\nPlease try again later",
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount),
            controller: _scrollController,
            itemCount: widget.count,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  widget.itemBuilder(context, index, refresh),
                  if (index == (widget.count - 1))
                    ValueListenableBuilder(
                        valueListenable: _showLoading,
                        builder: (context, value, _) {
                          if (value) {
                            return const Padding(
                              padding: EdgeInsets.all(30),
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                ],
              );
            }),
      );
    }
  }

  Future<void> _getData() async {
    widget.controller.state = PaginatedListViewState.loading;
    if (widget.totalPage == null || widget.totalPage == 0) {
      await widget.getData(widget.controller.page);
    } else {
      if (widget.controller.page <= widget.totalPage!) {
        await widget.getData(widget.controller.page);
      }
    }
    widget.controller.state = PaginatedListViewState.loaded;
  }

  Future<void> refresh() async {
    widget.controller.page = 1;
    await _getData();
  }

  @override
  void dispose() {
    _showLoading.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
