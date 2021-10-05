const fs = require("fs")

function main() {
    var sampleJson = `{
    "names": [
        {
            "first": "John",
            "last": "Doe"
        },
        {
            "first": "Jane",
            "last": "Doe"
        }
    ]
}`
    console.log(sampleJson)
    // Parse the json and return it.
    console.log(parseJson(sampleJson))
    // Validate the json and return true or false.
    console.log(validateJson(sampleJson))
    // Write the json to a file.
    writeToFile("JavaScript/sample.json", sampleJson)
    // Open a file and check if the json is valid
    console.log(checkIfFileIsValidJson("JavaScript/sample.json"))
}

main()

// Parse the json and return it.
function parseJson(json) {
    return JSON.parse(json)
}

// Validate the json and return true or false.
function validateJson(json) {
    try {
        JSON.parse(json)
        return true
    } catch (e) {
        return false
    }
}

// Open a file and check if it is a valid json.
function checkIfFileIsValidJson(filePath) {
    var json = fs.readFileSync(filePath, "utf8")
    return validateJson(json)
}

// Write some content to a specific file
function writeToFile(fileName, content) {
    fs.writeFile(fileName, content, function (err) {
        if (err) {
            return err
        }
    })
}