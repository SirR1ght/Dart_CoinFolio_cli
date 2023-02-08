import 'dart:io';
import 'dart:convert';
import 'package:coinfolio/tools.dart';
import 'package:characters/characters.dart';
import 'package:http/http.dart' as http;

late http.Client client = http.Client();

class Coin {
	final String symbol;
	final String price;

	const Coin({
		required this.symbol,
		required this.price,
	});

	factory Coin.fromJson(Map<String, dynamic> json) {
		return Coin(
			symbol: json['symbol'],
			price: json['price'],
		);
	}
	void printInfo() => print(this.toString());

	String toString() {
		return "${this.symbol} ${this.price}";
	}

	Future<http.Response> fetchCoin(List<String> url) async {
		return await http.get(Uri.parse(urlGet(url)));
	}
}

class CoinRecord {
	final Coin coin;
	final DateTime timeStamp;

	const CoinRecord({
		required this.coin,
		required this.timeStamp,
	});

	factory CoinRecord.fromJson(Map<String, dynamic> json, DateTime timestamp) {
		return CoinRecord(
			coin: Coin.fromJson(json),
			timeStamp: timestamp,
		);
	}

	void printInfo() => print(this.toString());

	String toString() {
		return "${coin.symbol}, ${coin.symbol}, ${this.timeStamp}";
	}
}

DateTime fromJson(Map<String, dynamic> json) {
	return DateTime.fromMillisecondsSinceEpoch(json['serverTime']);
}

bool requestAllowed(http.Response response){
	if (response.statusCode == 200) {
		return true;
	}
	if (response.statusCode == 429) {
		print("Too many requests from your IP, back off for ${response.headers['retry-after']} seconds.");
		return false;
	} 
	if (response.statusCode == 418) {
		print("Your IP is banned! Weight for ${response.headers['retry-after']} seconds.");
		return false;
	}
	return false;
}
Future<http.Response> sendRequest(http.Response response) async {
	if (!requestAllowed(response))
		return response;
	return response;
}

List<String> symbolPrep(List<String> list) {
	
	if (list)
}

void searchCoin() async {
	print("Enter \u{1FA99} coin symbol to get it's price: ");
	String? inputText = stdin.readLineSync();
	//convert input to uppercase
	//add check for inapropriate input
	//manage escape sequences
	final response = await client.get(Uri.parse(endpointTime));
	if (inputText != null) {
		if (requestAllowed(response)) {
			print(response.statusCode);
			print('Нормально все!');
		} else {
		// final response = await client.get(Uri.parse(urlGet([inputText])));
			print(response.statusCode);
		}
	}
	// if (inputText != null) {
	// 	final response = await client.get(Uri.parse(urlGet([inputText])));
	// 	if (response.statusCode == 200) {
	// 		Coin testcoin = Coin.fromJson(jsonDecode(response.body));
	// 		testcoin.printInfo();
	// 	} else {
	// 		print("Error: ${response.statusCode}");
	// 	}
	// }
}

void main(List<String> arguments) async {

	// Coin testcoin = Coin.fromJson(jsonDecode(response.body));
	// testcoin.printInfo();
	// response.headers.forEach((key, value) => print('$key: $value'));

	print_intro();
	while (true) {
		String? inputText = stdin.readLineSync();
		if (inputText != null) {
			if (inputText == "EXIT" || inputText == "exit") {
				client.close();
				break;
			} else if (inputText == "SEARCH" || inputText == "search") {
				searchCoin();
				break;
			} else if (inputText == "LIST" || inputText == "list") {
				break;
			} else {
				getLine('\u{1F9D0} Unknown command! Please try again.', false);
			}
		}
	}
}
	//TODO прочитать про линтер
	//TODO пройти кодлабу по ассинхронному дарту
	//TODO read about try and catch for errors
	//TODO rewrite sendRequest

	//TODO implement a websocket api connection
