.pragma library

// Number precision to avoid bloating ui with long numbers
function precise(number, precision) {
    if (precision === undefined)
        precision = 4
    // toPrecision returns a string
    return Number(Number(number).toFixed(precision))
}
