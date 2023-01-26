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

