import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_network/flutter_network.dart';

import 'mock_connectivity.dart';

void main() {
  test('Logger test', () async {
    const path = 'example.com';
    final Dio dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    final service = NetworkService(
      NetworkOptions(
        dio: dio,
        connection: Connection(
          connectivity: MockConnectivity(ConnectivityResult.wifi),
        ),
      ),
    );
    const data = {
      "data": [
        {
          "id": "bitcoin",
          "rank": "1",
          "symbol": "BTC",
          "name": "Bitcoin",
          "supply": "19326843.0000000000000000",
          "maxSupply": "21000000.0000000000000000",
          "marketCapUsd": "540058262392.7814769095939894",
          "volumeUsd24Hr": "9295496197.6948991003285596",
          "priceUsd": "27943.4288565794981058",
          "changePercent24Hr": "1.8047958796405348",
          "vwap24Hr": "28160.6558822649712706",
          "explorer": "https://blockchain.info/",
          "data": [
            {"name": "test name 1", "title": "title title 1"},
            {"name": "test name 2", "title": "title title 2"}
          ]
        },
        {
          "id": "ethereum",
          "rank": "2",
          "symbol": "ETH",
          "name": "Ethereum",
          "supply": "122373866.2178000000000000",
          "maxSupply": null,
          "marketCapUsd": "216164511403.8554668777094804",
          "volumeUsd24Hr": "4978344504.3701055226354794",
          "priceUsd": "1766.4270818993954840",
          "changePercent24Hr": "0.7764449047813918",
          "vwap24Hr": "1807.2642045266677431",
          "explorer": "https://etherscan.io/"
        },
      ],
      "some_field": "some_data"
    };
    dioAdapter.onGet(path, (server) => server.reply(200, data));
    await service.get(path, (json) => null);
  });
}

// ┃ {
// ┃  data: [
// ┃    {
// ┃      id: bitcoin,
// ┃      rank: 1,
// ┃      symbol: BTC,
// ┃      name: Bitcoin,
// ┃      supply: 19326843.0000000000000000,
// ┃      maxSupply: 21000000.0000000000000000,
// ┃      marketCapUsd: 540058262392.7814769095939894,
// ┃      volumeUsd24Hr: 9295496197.6948991003285596,
// ┃      priceUsd: 27943.4288565794981058,
// ┃      changePercent24Hr: 1.8047958796405348,
// ┃      vwap24Hr: 28160.6558822649712706,
// ┃      explorer: https://blockchain.info/
// ┃    },
// ┃    {
// ┃      id: ethereum,
// ┃      rank: 2,
// ┃      symbol: ETH,
// ┃      name: Ethereum,
// ┃      supply: 122373866.2178000000000000,
// ┃      maxSupply: null,
// ┃      marketCapUsd: 216164511403.8554668777094804,
// ┃      volumeUsd24Hr: 4978344504.3701055226354794,
// ┃      priceUsd: 1766.4270818993954840,
// ┃      changePercent24Hr: 0.7764449047813918,
// ┃      vwap24Hr: 1807.2642045266677431,
// ┃      explorer: https://etherscan.io/
// ┃    }
// ┃  ]
// ┃ }
