# SwearWordFilter

<p align="center">
  <img alt="Swift" src="https://img.shields.io/badge/Swift-5.9-orange.svg">
</p>    
<p align="center">
  <img alt="SPM" src="https://img.shields.io/badge/SPM -red.svg">
</p>

**Swear WordFilter** is a library that filters profanity in iOS environments.
This library allows you to use text that replaces abusive language and inclusion of abusive language.

Although basic Korean and English swear words are included inside the library, you can add them yourself or remove existing words.

Currently, there is a build problem with CocoPod when using `Bundel.module`, so we will support CocoPod after solving it.
Please import **SwearWordFilter** through SPM.

## Basic Concept

**Trie Tree** was applied to filter Swear Word. 
Apply Trie Tree, we were able to have a time complexity of O(n + m) compared to O(n^2) using overlapping iterations with `contains()`.


### SwearWordFilter

You can use each feature by creating **SwearWordFilter** objects.

```swift=
let swFilter = SwearWordFilter()

let badWord = "BADWORD"
swFilter.addSwearWord(badWord)
swFilter.containSwearWord("This is BADWORD Text!") // True

// If you don't want to use Trie Tree and want a general Text navigation, 
// choose Direct Type.
swFilter.containSwearWord("This is BADWORD Text!", type: .direct) // True

swFilter.replaceSwearWord("This is a BadWord Text!", withChar: "#") 
// This is a ####### Text!
swFilter.removeSwearWord(badWord)
swFilter.containSwearWord("This is BADWORD Text!") // False


let badWords = ["BAD", "Super Bad", "Very Bad"]
swFilter.addSwearWord(badWords)
swFilter.removeSwearWord(badWords)

```


### SwearWordsContainer

This Class Type serves as a data structure for managing and exploring Swear Word List.

`containsSwearWordTrieTree(text: String) -> Bool` : O(N), Using Trie Tree
`containsSwearWordDirect(text: String) -> Bool` : O(N^2), Using Nested Iteratorion and `.contain()`

Measuring the search time of 20,000,000-length Text
|Trie Tree|Nested Iterator|
|---|---|
|0.127(sec)|16.358(sec)|


### Testing

- SwearWordFilter Logic Test
- SwearWordsContainer Logic Test

## Requirements

* Swift 5.9

## Installation

**Podfile**

Currently, there is a build problem with CocoPod when using `Bundel.module`, so we will support CocoPod after solving it.


## VersionLog

* 2024-04-05 / 1.0.0
    * First Deployment
* 2024-04-05 / 1.0.1
    * Add ReadMe

## License

SwearWordFilter is under MIT license. See the [LICENSE](https://github.com/KyoPak/Swear-Word-Filter/blob/main/LICENSE) for more info.
