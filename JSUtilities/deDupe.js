const fs = require('fs')
const jsonContent = JSON.parse(fs.readFileSync('../vehicles.json'))

const readFile = (file) => JSON.parse(fs.readFileSync(file))
const writeFile = (file, json) => fs.writeFileSync(file, json, 'utf8')

const removeDuplicates = (myArr, prop)  => {
    return myArr.filter((obj, pos, arr) => {
        return arr.map(mapObj => mapObj[prop]).indexOf(obj[prop]) === pos;
    });
}

//console.log(removeDuplicates(readFile('../vehicles.json'), 'image_url'))
writeFile('vehicles_deduped.json', JSON.stringify(removeDuplicates(readFile('../vehicles.json'), 'image_url')))