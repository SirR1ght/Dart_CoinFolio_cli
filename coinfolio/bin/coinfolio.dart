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

class Album {
	final int userId;
	final int id;
	final String title;

	const Album({
		required this.id,
		required this.userId,
		required this.title,
	});

	factory Album.fromJson(Map<String, dynamic> json) {
		return Album(
			userId: json['userId'],
			id: json['id'],
			title: json['title'],
	);
	}

	void printInfo() => print(this.toString());

	String toString() {
		return '${this.id} ${this.userId}, ${this.title}';
	}
}
// с
List<String> symbs = ["BTCUSDT","BNBUSDT"];

//сделать так что бы переменные листа были вставленны один за одним
String urlGet(List<String> list) {
	//TODO name it properly
	if (list.length == 1) {
		String preparedUrl = "$endpointPrice?symbol=${list[0]}";
		return preparedUrl;
	} else if (list.length > 1) {
		//напечатать весь лист в строку
		String preparedUrl = "$endpointPrice?symbols=";
		for (list in )
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

	// 	}
}

	response.headers.forEach((key, value) => print('$key: $value'));




Future<void> fetchAlbum() async {

	String symbol = 'BNBBUSD';
	final url = '$endpointPrice?symbol=$symbol';
	
	// for (int i = 0; i < 40; i++) {

	http.Request 


	var request = http.Request('GET', Uri.parse(url));

	var response = await http.get(Uri.parse(url));




	var usedWeight = response.headers['x-mbx-used-weight'];
		print(response.body);
	// print('${i} = x-mbx-used-weight: $usedWeight, statusCode: ${response.statusCode}');
	
	if (response.statusCode == 429) {
		// Handle the rate limit
		print("Too many requests from your IP, backing off for ${response.headers['retry-after']} seconds");
		response.headers.forEach((key, value) => print('$key: $value'));
		// return false;
	} else if (response.statusCode == 418) {
		// var banExpiration = DateTime.now().add(Duration(seconds: banDuration));
		print("Your IP is banned until");
		response.headers.forEach((key, value) => print('$key: $value'));

	// 	}
	//return false;
	// }
	}


	// response.headers.forEach((key, value) => print('$key: $value'));
	
	

	// bool requestAllowed(http.Response response) {

	// 	if (response.statusCode == 429) {
	// 	// Handle the rate limit
	// 		print("Too many requests from your IP, backing off for ${response.headers['retry-after']} seconds");
	// 		return false;
	// 	} else if (response.statusCode == 418) {
	// 		var banExpiration = DateTime.now().add(Duration(seconds: banDuration));
	// 		print("Your IP is banned until $banExpiration");
	// 		return false;
	// }

	
	
	// if (response.statusCode == 200) {
	  return Album.fromJson(jsonDecode(response.body));
	// } else {
	//   throw Exception('Failed to load album');
	// }
// 	if (response.statusCode == 429) {
//     // Handle the rate limit
//     var retryAfter = int.parse(response.headers['retry-after']);
//     print("Too many requests from IP $ip, backing off for $retryAfter seconds");
//     return false;
//   } else if (response.statusCode == 418) {
//     // Handle IP ban
//     var banDuration = int.parse(response.headers['x-mbx-ban-duration']);
//     var banExpiration = DateTime.now().add(Duration(seconds: banDuration));
//     bannedIps[ip] = banExpiration;
//     print("IP $ip is banned until $banExpiration");
//     return false;


void main(List<String> arguments) async {
//   print_intro();
	fetchAlbum();
	// Album album = await fetchAlbum();
	// fetchAlbum().then((value) => {value.printInfo()});
	// album.printInfo();



}