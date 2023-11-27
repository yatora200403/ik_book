import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkApi {
  static String? _serverName, _action, _customAction, _fileEnd;

  static List<dynamic> _allBooks = [];

  static set setServerName(String newName) {
    _serverName = newName;
  }

  static get getServerName {
    return _serverName;
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

  static setAllBookApi() async {
    NetworkApi.setActionApi = "getallbooks";
    NetworkApi.setFileEnd = "book";

    final response = await http.get(
      Uri.parse(NetworkApi.getPostUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    List<dynamic> listResponse = [];
    if (response.statusCode == 200) {
      listResponse = jsonDecode(response.body);
    }
    _allBooks.addAll(listResponse);
  }

  static List<dynamic> get getAllBooks {
    return _allBooks;
  }

  static void addBook(Map<String, dynamic> book) {
    _allBooks.add(book);
  }

  static void editBook(Map<String, dynamic> editedBook) {
    List<dynamic> selectedBookApi = _allBooks
        .where((book) => book['id_buku']
            .toString()
            .toLowerCase()
            .contains(editedBook['id_buku'].toString().toLowerCase()))
        .toList();

    if (selectedBookApi != []) {
      int selectedIndex = _allBooks.indexOf(selectedBookApi[0]);
      _allBooks[selectedIndex] = editedBook;
    }
  }

  static void deleteBook(int index) {
    _allBooks.removeAt(index);
  }
}
