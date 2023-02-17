
const endpointPing = "https://api.binance.com/api/v3/ping";
const endpointPrice = "https://api.binance.com/api/v3/ticker/price";
const endpoint24hr = "https://api.binance.com/api/v3/ticker/24hr";
const endpointTime = "https://api.binance.com/api/v3/time";

const int column_width = 60;
const lineStart = '*~~~';
const lineEnd = '~~~*';
const usedSpace = lineStart.length + lineEnd.length;
const freeSpace = column_width - usedSpace;
final topBottom = '*' * (column_width);
final midle = lineStart + '~' * freeSpace + lineEnd;

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

void getLine(String text, bool command) {
	final int spaceBetween = (freeSpace - text.length) ~/ 2;
	if (!command) { // To make lines look even to each other
		//To make text even
		text = text.length.isEven ? text : text += ' ';
		// if (text.length % 2 != 0) {
		// text += ' ';
		// }
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