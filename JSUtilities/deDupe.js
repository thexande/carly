const fs = require('fs')
const jsonContent = JSON.parse(fs.readFileSync('../vehicles.json'))

const readFile = (file) => JSON.parse(fs.readFileSync(file))
const writeFile = (file, json) => fs.writeFileSync(file, json, 'utf8')

const unique = (arr) => {
    var comparer = function compareObject(a, b) {
        if (a.title == b.title) {
            if (a.artist < b.artist) {
                return -1;
            } else if (a.artist > b.artist) {
                return 1;
            } else {
                return 0;
            }
        } else {
            if (a.title < b.title) {
                return -1;
            } else {
                return 1;
            }
        }
    }
    arr.sort(comparer);
    for (var i = 0; i < arr.length - 1; ++i) {
        if (comparer(arr[i], arr[i+1]) === 0) {
            arr.splice(i, 1);
        }
    }
    return arr
}

writeFile('../vehicles_deduped.json', JSON.stringify(unique(readFile('../vehicles.json'))))