import 'dart:io';
import 'dart:convert';
import 'package:coinfolio/tools.dart';
import 'package:characters/characters.dart';
import 'package:http/http.dart' as http;

const int column_width = 60;
final topBottom = '*' * (column_width);
final midle = lineStart + '~' * freeSpace + lineEnd;
const lineStart = '*~~~';
const lineEnd = '~~~*';
const usedSpace = lineStart.length + lineEnd.length;
const freeSpace = column_width - usedSpace;

void getLine(String text, bool command) {
	final int spaceBetween = (freeSpace - text.length) ~/ 2;
	if (!command) { // To make lines look even to each other
		//To make text even
		if (text.length % 2 != 0) {
		text += ' ';
		}
		//Combines whole line
		String output = '$lineStart${' ' * spaceBetween}$text${' ' * spaceBetween}$lineEnd';
		return print(output);
	} else {
		//It's not perfect but it's good for now
		final int frontIndent = freeSpace ~/ 10;
		// final int frontIndent = ((freeSpace ~/ 2) * 10);
		final int backIndent = freeSpace - frontIndent - text.length;
		String output = '$lineStart${' ' * frontIndent}$text${' ' * backIndent}$lineEnd';
		return print(output);
	}
}

void print_intro() {

	const welcome = '\u{1F3E6} 💵 💴 \u{1F4C9}  Welcome to CoinFolio  \u{1F4C8} 💶 💷 \u{1F4B0}';
	const canUse = 'You can use these commands:';
	const search = '\u{1F50D} SEARCH - to look for current assets value';
	const list = '\u{1F4D2} LIST - to display all portfolio';
	const exit = '\u{1F6AA} EXIT - to quit';
	
	print(topBottom);
	getLine(welcome, false);
	print(midle);
	getLine(canUse, false);
	getLine(search, true);
	getLine(list, true);
	getLine(exit, true);
	print(topBottom);

// 	print ('''
// ************************************************************
// *~~~                Welcome to CoinFolio                ~~~*
// *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
// *~~~            You can use these commands:             ~~~*
// *~~~     SEARCH - to look for current assets value      ~~~*
// *~~~     LIST   - to display all portfolio              ~~~*
// *~~~     EXIT   - to quit                               ~~~*
// ************************************************************
// ''');
}

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

void main(List<String> arguments) async {

	// final response = await client.get(Uri.parse(urlGet(["BNBBUSD"])));
	// final response = await client.get(Uri.parse(endpointTime));
	// Coin testcoin = Coin.fromJson(jsonDecode(response.body));
	// testcoin.printInfo();
	// response.headers.forEach((key, value) => print('$key: $value'));

	print_intro();
	while (true) {
		String? inputText = stdin.readLineSync();
		if (inputText != null) {
			if (inputText == "EXIT" || inputText == "exit") {
				break;
			} else if (inputText == "SEARCH" || inputText == "search") {
				break;
			} else if (inputText == "LIST" || inputText == "list") {
				break;
			} else {
				getLine('\u{1F9D0} Unknown command! Please try again.', false);
			}
	// 	final client = http.Client();

	// print('\u{1F310}');
	// print('\u{1F911}');
	// print('\u{1F45B}');
	// print('\u{1F3E6}');
	// print('💵💴💶💷');
	// print('\u{1F4C8}');
	// print('\u{1F4B0}');
	// print('\u{1F4C9}');
	// print('\u{1F4C8}');
	// print('\u{1FA99}');
	// print('\u{1F4BC}');
	}
	// client.close();
	}
}
	//TODO пройти кодлабу по ассинхронному дарту
	//TODO read about try and catch for errors
	//TODO rewrite sendRequest

	//TODO implement a websocket api connection
