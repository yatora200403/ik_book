class NetworkApi {
  static String? _serverName, _action, _customAction, _fileEnd;

  static List<dynamic> _apiBooks = [];
  static List<dynamic> _localBooks = [];
  static List<dynamic> _allBooks = _apiBooks + _localBooks;

  static set setServerName(String newName) {
    _serverName = newName;
  }

  static set setActionApi(String action) {
    _action = action;
  }

  static set setFileEnd(String fileName) {
    _fileEnd = "$fileName.php";
  }

  static set setCustomAction(String action) {
    _customAction = action;
  }

  static String get getPostUrl {
    return "http://$_serverName/ik_book_api/$_fileEnd?action=$_action";
  }

  static String get getGetUrl {
    return "http://$_serverName/ik_book_api/$_fileEnd?action=$_action$_customAction";
  }

  static set setAllBooksApi(List<dynamic> listBooks) {
    _apiBooks.addAll(listBooks);
  }

  static List<dynamic> get getAllBooks {
    return _allBooks;
  }

  static void addBook(Map<String, dynamic> book) {
    _localBooks.add(book);
    _allBooks.clear();
    _allBooks = _apiBooks + _localBooks;
  }

  static void editBook(Map<String, dynamic> editedBook) {
    List<dynamic> selectedBookApi = _apiBooks
        .where((book) => book['id_buku']
            .toString()
            .toLowerCase()
            .contains(editedBook['id_buku'].toString().toLowerCase()))
        .toList();
    List<dynamic> selectedBookLocal = _localBooks
        .where((book) => book['id_buku']
            .toString()
            .toLowerCase()
            .contains(editedBook['id_buku'].toString().toLowerCase()))
        .toList();

    if (selectedBookApi != []) {
      int selectedIndex = _apiBooks.indexOf(selectedBookApi[0]);
      _apiBooks[selectedIndex] = editedBook;
    } else if (selectedBookLocal != []) {
      int selectedIndex = _localBooks.indexOf(selectedBookLocal[0]);
      _localBooks[selectedIndex] = editedBook;
    }
    _allBooks.clear();
    _allBooks = _apiBooks + _localBooks;
  }

  static void deleteBook(int index) {
    _allBooks.removeAt(index);
  }
}
