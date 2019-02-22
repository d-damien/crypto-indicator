.pragma library
.import "Error.js" as Error


function get(url, params, callback) {
    return request('GET', url, params, callback)
}

function put(url, params, callback) {
    return request('PUT', url, params, callback)
}

function request(method, url, params, callback) {
    if (method === 'GET')
        url += serialize(params)
    else if (method === 'PUT')
        params = JSON.stringify(params)

    let xhr = new XMLHttpRequest
    xhr.onreadystatechange = function() {
        // @TODO handle net errors
        if (xhr.readyState === XMLHttpRequest.DONE) {
            try {
                callback(null, JSON.parse(xhr.responseText))
            } catch (e) {
                callback(Error.PARSE)
            }
        }
    }

    xhr.open(method, url)
    xhr.setRequestHeader('User-Agent', '')
    xhr.send(params)
}

// private
// serialize for get()
function serialize(params) {
    let s = '?'
    for (var p in params) {
        s += p + '=' + params[p] + '&'
    }

    return s.substr(0, s.length-1)
}
