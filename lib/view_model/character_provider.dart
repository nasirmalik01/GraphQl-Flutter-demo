import 'package:flutter/material.dart';
import 'package:graphql_demo/models/characters.dart';
import 'package:graphql_demo/utils/consts.dart';

class CharacterProvider with ChangeNotifier{
  static int pageNum = 1;

   List<Character> getCharactersFromAPI({var parsedJson}) {
    final productList = parsedJson['characters']['results'] as List;
    var characters = productList.map((i) => Character.fromJSON(i)).toList();
    return characters;
  }

  goNext(BuildContext context){
     if(pageNum < 6) {
       pageNum = pageNum+1;
       notifyListeners();
     }
     else {
       ScaffoldMessenger.of(context).hideCurrentSnackBar();
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
  }

  goPrev(){
    if(pageNum > 1){
      pageNum = pageNum - 1;
      notifyListeners();
    }
  }
}