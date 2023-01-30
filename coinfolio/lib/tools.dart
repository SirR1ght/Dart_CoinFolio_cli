const endpointPing = "https://api.binance.com/api/v3/ping";
const endpointPrice = "https://api.binance.com/api/v3/ticker/price";
const endpoint24hr = "https://api.binance.com/api/v3/ticker/24hr";

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


// void print_intro() {

// 	stdout.write('|');
// 	print ('******************************************************\n'
// 		'*~~~           Welcome to CoinFolio           ~~~*\n'
// 		'*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*\n'
// 		'*~~~         You can use these commands:           ~~~*\n'
// 		'*~~~      SEARCH - to look for current assets value ~~~*\n'
// 		'*~~~      LIST    - to display all portfolio          ~~~*\n'
// 		'*~~~      EXIT   - to quit                        ~~~*\n'
// 		'******************************************************');
// }