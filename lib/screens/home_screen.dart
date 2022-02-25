import 'package:flutter/material.dart';
import 'package:graphql_demo/models/characters.dart';
import 'package:graphql_demo/view_model/character_provider.dart';
import 'package:graphql_demo/view_model/network/remote_repository.dart';
import 'package:graphql_demo/widgets/app_bar_text.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
   List<Character> _characterList = [];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _characterProvider = Provider.of<CharacterProvider>(context);

    var productsGraphQL = """
    query {
  characters(page: ${CharacterProvider.pageNum}, filter: { name: "rick" }) {
    info {
      count
    }
    results {
      name
    }
  }
  location(id: 1) {
    id
  }
  episodesByIds(ids: [1, 2]) {
    id
  }
}
  """;

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
        link: RemoteRepository.httpLink,
        cache: GraphQLCache(
            store: InMemoryStore())
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        leading: InkWell(
            onTap: () async {
              await _characterProvider.goPrev();
            },
            child: Center(child: appBarText(title: 'Prev'))),
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: InkWell(
                onTap: () async {
                  await _characterProvider.goNext(context);
                },
                child: Center(child: appBarText(title: 'Next'))),
          )
        ],
      ),
      body: GraphQLProvider(
        client: client,
        child: Query(
          options: QueryOptions(
              document: gql(productsGraphQL)
          ),
          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore}) {
            if(result.isLoading){
              return const Center(
                child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)
                ),
              );
            }

            _characterList =  _characterProvider.getCharactersFromAPI(parsedJson: result.data);

            return ListView.builder(
              itemCount: _characterList.length,
              itemBuilder: (_,  index){
                return Padding(
                  padding: EdgeInsets.all(1.h),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                        title: Text(_characterList[index].name)),
                  ),
                );
              },
            );
          },
        ),),
      );

  }
}
