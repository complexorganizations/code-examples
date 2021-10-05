function main() {
    // Create a array of int
    var array = [5, 3, 1, 2, 4]
    console.log(array)
    // Join the array
    console.log(joinArray(array, '-'))
    // Sort the array
    console.log(sortArray(array))
    // Create a new array of objects.
    var people = [
        "t",
        "b",
        "l",
        "y",
        "k",
        "i",
        "j",
        "c",
        "a",
        "e",
        "n",
        "d",
        "s",
        "m",
        "p",
        "f",
        "z",
        "r",
        "q",
        "w",
        "u",
        "v",
        "x",
        "o",
        "h",
        "g"
    ]
    console.log(people)
    sortArray(people)
    console.log(people)
    // Get the first value
    console.log(getFirstValue(array))
    // Get the last value
    console.log(getLastValue(array))
    // Get the length of the array
    console.log(getLength(array))
    // Randomly pick a value from the array
    console.log(getRandomValue(array))
    // Randomize the order of the values in the array
    console.log(randomizeArray(array))
    // Add a value to the end of the array
    console.log(addToEnd(array, 6))
    // Add a value to the start of the array
    console.log(addToStart(array, 0))
    // Remove the first value in the array
    console.log(removeFirstValue(array))
    // Remove the last value in the array
    console.log(removeLastValue(array))
    // Remove a value from the array
    console.log(removeValue(array, 3))
    // Remove all instances of a value from the array
    console.log(removeAllValues(array, 3))
    // Remove all the content from the array
    console.log(removeAllContent(array))
    // Reverse the order of the values in the array
    console.log(reverseArray(array))
    // Get the index of a value in the array
    console.log(getIndex(array, 3))
    // Remove all duplicates from an array
    console.log(removeDuplicates(array))
    // Combine two arrays
    console.log(combineArrays(array, [6, 7, 8]))
    // Check if the array is empty
    console.log(isArrayEmpty(array))
    // Check if the array is not empty
    console.log(isNotEmptyArray(array))
}

main()

// Join the array.
function joinArray(array, separator) {
    return array.join(separator)
}

// Sort all the data in the array, and return the sorted array
function sortArray(array) {
    array.sort()
    return array
}

// Get the first value in the array and return it
function getFirstValue(array) {
    return array[0]
}

// Get the last value in the array and return it.
function getLastValue(array) {
    return array[array.length - 1]
}

// Get the length of the array and return it.
function getLength(array) {
    return array.length
}

// Randomly pick a value from the array and return it.
function getRandomValue(array) {
    return array[Math.floor(Math.random() * array.length)]
}

// Randomize the order of the values in the array and return the array.
function randomizeArray(array) {
    var newArray = []
    while (array.length > 0) {
        var randomIndex = Math.floor(Math.random() * array.length)
        var randomValue = array.splice(randomIndex, 1)
        newArray.push(randomValue[0])
    }
    return newArray
}

// Add a value to the end of the array and return the array.
function addToEnd(array, value) {
    array.push(value)
    return array
}

// Add a value to the start of the array and return the array.
function addToStart(array, value) {
    array.unshift(value)
    return array
}

// Remove the first value in the array and return the array.
function removeFirstValue(array) {
    array.shift()
    return array
}

// Remove the last value in the array and return the array.
function removeLastValue(array) {
    array.pop()
    return array
}

// Remove a value from the array and return the array.
function removeValue(array, value) {
    var index = array.indexOf(value)
    if (index > -1) {
        array.splice(index, 1)
    }
    return array
}

// Remove all instances of a value from the array and return the array.
function removeAllValues(array, value) {
    var index = array.indexOf(value)
    while (index > -1) {
        array.splice(index, 1)
        index = array.indexOf(value)
    }
    return array
}

// Remove all the content from the array and return the array.
function removeAllContent(array) {
    array.length = 0
    return array
}

// Reverse the order of the values in the array and return the array.
function reverseArray(array) {
    return array.reverse()
}

// Get the index of a value in the array and return it.
function getIndex(array, value) {
    return array.indexOf(value)
}

// Remove all duplicates from an array and return the array.
function removeDuplicates(array) {
    var newArray = []
    for (var i = 0; i < array.length; i++) {
        if (newArray.indexOf(array[i]) == -1) {
            newArray.push(array[i])
        }
    }
    return newArray
}

// Combine two arrays and return the array.
function combineArrays(array1, array2) {
    return array1.concat(array2)
}

// Check if the array is empty.
function isArrayEmpty(array) {
    return array.length == 0
}

// Check if the array is not empty.
function isNotEmptyArray(array) {
    return array.length >= 1
}