.pragma library
.import "../util/Http.js" as Http

// classes should come in Qt 5.12 with ES7


/**
  API url root
*/
function baseUrl() { }

/**
  List available pairs
*/
function list() { }


/**
  Get pair currrent info
  @param symbol pair name on the exchange
*/
function ticker(symbol) { }


/**
  Change pair value to USDT value
  @param pair { symbol, price }
*/
function toUSDT(symbol, value) { }
