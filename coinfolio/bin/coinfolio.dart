import 'dart:io';
import 'dart:convert';
// import 'package:cli/cli.dart' as cli;
import 'package:http/http.dart' as http;

const int column_width = 10;
const endpointPing = "https://api.binance.com/api/v3/ping";
const endpointPrice = "https://api.binance.com/api/v3/ticker/price";
const endpoint24hr = "https://api.binance.com/api/v3/ticker/24hr";


void print_intro() {

	stdout.write('|');
	print ('******************************************************\n'
		'*~~~           Welcome to CoinFolio           ~~~*\n'
		'*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\n'
		'*~~~         You can use these commands:           ~~~*\n'
		'*~~~      SEARCH - to look for current assets value ~~~*\n'
		'*~~~      LIST    - to display all portfolio          ~~~*\n'
		'*~~~      EXIT   - to quit                        ~~~*\n'
		'******************************************************');
}

class Coin {
	final String symbol;
	final int price;

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
}

String urlGet(List<String> list) {
	if (list.length == 1) {
		String preparedUrl = "$endpointPrice?symbol=${list[0]}";
		return preparedUrl;
	} else if (list.length > 1) {
		String preparedUrl = "$endpointPrice?symbols=[";
		for (final symbol in list) {
			preparedUrl += "\"$symbol\",";
		}
		preparedUrl = preparedUrl.substring(0, preparedUrl.length - 1);
		preparedUrl += "]";
		return preparedUrl;
	}
	return endpointPrice;
}


bool requestAllowed(http.Response response){
	if (response.statusCode == 429) {
		// Handle the rate limit
		print("Too many requests from your IP, backing off for ${response.headers['retry-after']} seconds");
		return false;
	} else if (response.statusCode == 418) {
		// var banExpiration = DateTime.now().add(Duration(seconds: banDuration));
		print("Your IP is banned until");
		response.headers.forEach((key, value) => print('$key: $value'));
	} else if (response.statusCode == 200) {
	  return true;
	}
}

Future<void> fetchAlbum() async {
// 	var request = http.Request('GET', Uri.parse(url));
// 	var response = await http.get(Uri.parse(url));
}

void main(List<String> arguments) async {
	// Album album = await fetchAlbum();
	// fetchAlbum().then((value) => {value.printInfo()});
// response.headers.forEach((key, value) => print('$key: $value'));
}