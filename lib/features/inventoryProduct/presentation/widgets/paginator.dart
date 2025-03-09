class Paginator<T> {
  final List<T> _items;
  final int pageSize; // حجم الصفحة المحدد
  int _currentPage = 0;

  Paginator(this._items, {required this.pageSize});

  int get currentPage => _currentPage + 1; // الصفحات تبدأ من 1
  int get totalPages => (_items.length / pageSize).ceil(); // العدد الكلي للصفحات

  List<T> getNextPage() {
    if (!hasNextPage()) return [];

    int start = _currentPage * pageSize;
    int end = (start + pageSize).clamp(0, _items.length);

    _currentPage++;
    return _items.sublist(start, end);
  }

  List<T> getPreviousPage() {
    if (!hasPreviousPage()) return [];

    _currentPage--;
    int start = _currentPage * pageSize;
    int end = (start + pageSize).clamp(0, _items.length);

    return _items.sublist(start, end);
  }

  bool hasNextPage() {
    return _currentPage < totalPages;
  }

  bool hasPreviousPage() {
    return _currentPage > 0;
  }

  void reset() {
    _currentPage = 0;
  }
}
