import 'dart:io';
import 'dart:convert';
import 'package:coinfolio/tools.dart';
import 'package:http/http.dart' as http;

const int column_width = 10;

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

bool requestAllowed(http.Response response){
	if (response.statusCode == 200) {
		return true;
	}
	if (response.statusCode == 429) {
		print("Too many requests from your IP, backing off for ${response.headers['retry-after']} seconds");
		return false;
	} 
	if (response.statusCode == 418) {
		print("Your IP is banned until");
		response.headers.forEach((key, value) => print('$key: $value'));
		return false;
	}
	return false;
}
	//sendRequest() async{}
	// написать стресс тест для получения кода 418 и посмотреть тело ответа
void main(List<String> arguments) async {
	final client = http.Client();
	
	final response = await client.get(Uri.parse(urlGet(["BNBBUSD"])));
	Coin testcoin = Coin.fromJson(jsonDecode(response.body));
	testcoin.printInfo();
	client.close();
	}
