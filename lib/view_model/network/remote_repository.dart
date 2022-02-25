import 'package:graphql_flutter/graphql_flutter.dart';

class RemoteRepository{
  static final HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');
}