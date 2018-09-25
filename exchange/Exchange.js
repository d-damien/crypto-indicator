.pragma library
.import "../util/Http.js" as Http

// classes should come in Qt 5.12 with ES7


/**
  API url root
*/
function baseUrl() { }

/**
  List available pairs
  @param callback asynchronous
*/
function list(callback) { }


/**
  Get pair currrent info
  @param symbol pair name on the exchange
  @param callback asynchronous
*/
function ticker(symbol, callback) { }


/**
  Change pair value to USDT value
  @param pair { symbol, price }
*/
function toUSDT(symbol, value) { }

/**
  Translate exchange notation to program notation
  or the other way around
  @param symbol to translate
  @param exchangeToProgram boolean direction
*/
function clarify(symbol, exchangeToProgram) { }
