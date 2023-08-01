import 'package:flutter/material.dart';
import 'package:health_taylor/ev.dart';
import 'package:health_taylor/ev_provider.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatelessWidget {
  ListWidget({Key? key}) : super(key: key);

  late EvProvider _evProvider; // EvProvider 호출

  Widget _makeEvOne(Ev ev) {
    return Row(
      children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    ev.height.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ev.weight.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  // 리스트 뷰
  Widget _makeListView(List<Ev> evs) {
    return ListView.separated(
      itemCount: evs.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 300, color: Colors.white, child: _makeEvOne(evs[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of를 통해 데이터를 접근한다. builder만을 업데이트 하기 위해 listen은 false로 한다.
    _evProvider = Provider.of<EvProvider>(context, listen: false);
    _evProvider.loadEvs(); // EvProvider에 loadEvs()의 접근

    return Scaffold(
        appBar: AppBar(
          title: Text("건강검진 데이터"),
        ),
        // Consumer를 통해 데이터를 접근
        body: Consumer<EvProvider>(builder: (context, provider, wideget) {
          // 데이터가 있으면 _makeListView에 데이터를 전달
          if (provider.evs != null && provider.evs.length > 0) {
            return _makeListView(provider.evs);
          }

          // 데이터가 없으면 CircularProgressIndicator 수행(로딩)
          return Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}