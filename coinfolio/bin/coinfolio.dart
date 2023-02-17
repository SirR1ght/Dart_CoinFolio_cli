import 'dart:io';
import 'dart:convert';
import 'package:coinfolio/tools.dart';
import 'package:characters/characters.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

late http.Client client = http.Client();
List <CoinRecord> folio = [];

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
	void printInfo() => print(toString());

	@override
	String toString() {
		return "\u{2705} $symbol Price: $price";
	}

	Future<http.Response> fetchCoin(List<String> url) async {
		return await http.get(Uri.parse(urlGet(url)));
	}
}

class CoinRecord {
	final Coin coin;
	final int amount;
	final DateTime timeStamp;

	const CoinRecord({
		required this.coin,
		required this.amount,
		required this.timeStamp,
	});

	factory CoinRecord.fromJson(Coin coin, int amount, DateTime timestamp) {
		return CoinRecord(
			coin: coin,
			amount: amount,
			timeStamp: DateTime.now(),
		);
	}

	void printInfo() => print(toString());

	@override
	String toString() {
		return "\u{2757} ${coin.symbol}, ${coin.symbol}, $timeStamp";
	}
}

DateTime fromJson(Map<String, dynamic> json) {
	return DateTime.fromMillisecondsSinceEpoch(json['serverTime']);
}

bool requestAllowed(http.Response response){
	if (response.statusCode == 200) {
		return true;
	}
	if (response.statusCode == 400) {
		print("\u{2757} Bad request! Check your request parameters.");
		return false;
	}
	if (response.statusCode == 429) {
		print("\u{2757} Too many requests from your IP, back off for ${response.headers['retry-after']} seconds.");
		return false;
	} 
	if (response.statusCode == 418) {
		print("\u{2757} Your IP is banned! Weight for ${response.headers['retry-after']} seconds.");
		return false;
	}
	return false;
}
Future<http.Response> sendRequest(http.Response response) async {
	if (!requestAllowed(response)) {
		return response;
	}
	return response;
}
List<String> symbolPrep(List<String> list) {
	for (String item in list){
		item.toUpperCase();
		}
	return list;
}

int coinAmount() {
	print("How many coins would you like to add?");
	while (true) {
		String? inputText = stdin.readLineSync();
		if (inputText != null) {
			if (inputText.contains(RegExp(r'^[0-9]+$'))) {
				int amount = int.parse(inputText);
				print("\u{2705} $amount will be added to your folio.");
				return amount;
			}
			print("\u{2757} Unknown command! Please enter amount of coins you would like to add.");
		}
	}
}

void addCoin(Coin coin) {
	print("Would you like to add a $coin to your folio? (Y/N)");
	while (true) {
		String? inputText = stdin.readLineSync();
		if (inputText != null) {
			if (inputText == "Y" || inputText == "y" || inputText == "YES" || inputText == "yes") {
				//ask how many coins would you like to add
				int amount = coinAmount();
				CoinRecord record = CoinRecord.fromJson(coin, amount, DateTime.now());
				folio.add(record);
				print("\u{2705} $amount coins of ${coin.symbol} were added to your folio.");
				break;
			}
			if (inputText == "N" || inputText == "n" || inputText == "NO" || inputText == "no") {
				print("$coin wasn't added to your folio.");
				break;
			}
			print("\u{2757} Unknown command! Please enter YES/NO.");
		}
	}
}

void searchCoin() async {
	print("Enter \u{1FA99} coin symbol to get it's price:");
	while (true) {
		String? inputText = stdin.readLineSync();
		//convert input to uppercase
		//add check for inapropriate input
		//manage escape sequences
		final response = await client.get(Uri.parse(endpointTime));
		if (inputText != null) {
			if (requestAllowed(response)) {
				if (!(inputText.contains(RegExp(r'^[a-zA-Z]+$')))) {
					print("\u{2757}Incorrect input! Your input should contain only letters.\nFor example BTC, ETH, DOGE, etc.");
					continue;
				}
				String data = inputText + 'BUSD'.toUpperCase();
				print (data);
				String testUrl = urlGet([data]);
				print("Test URL: $testUrl");
				final response = await client.get(Uri.parse(urlGet([data])));
				if (requestAllowed(response)) {
					print(response.body);
					Coin coin = Coin.fromJson(jsonDecode(response.body));
					coin.printInfo();
					addCoin(coin);
					break;
				}
				//
				//add smiles to printout
				//! write add function that adds coin to the the folio
			}

		}
	}
}
void listCoins() {
	print("Your folio:");
	for (CoinRecord record in folio) {
		record.printInfo();
	}
}

enum Menu {search, list, exit}

void main(List<String> arguments) async {

	// Coin testcoin = Coin.fromJson(jsonDecode(response.body));
	// testcoin.printInfo();
	// response.headers.forEach((key, value) => print('$key: $value'));

	print_intro();
	bool loop = true;
	while (loop) {
		String? inputText = stdin.readLineSync();
		if (inputText != null) {
			inputText = inputText.toUpperCase();
			// switch (inputText) {
			// 	case "EXIT":
			// 		client.close();
			// 		loop = false;
			// 		break;
			// 	case "SEARCH":
			// 		searchCoin();
			// 		break;
			// 	case "LIST":
			// 		listCoins();
			// 		break;
			// 	default:
			// 		getLine('\u{1F9D0} Unknown command! Please try again.', false);
			if (inputText == "EXIT") {
				client.close();
				loop = false;
				break;
			} else if (inputText == "SEARCH") {
				searchCoin();
				break;
			} else if (inputText == "LIST") {
				listCoins();
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