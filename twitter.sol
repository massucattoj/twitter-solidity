// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// https://www.youtube.com/watch?v=AYpftDFiIgk&t
// 1. create a twitter contract
// 2. create a mapping between user and tweet
// 3. add function to create a tweet and save it in mapping
// 4. create a function to get tweet
// 5. add arrays of tweets


// 6. define a tweet structure (author, content, timestamp, likes)
// 7. add the struct to the array

// 8. use require to limit the length of the tweet to be only 280 characters 

// 9. add a function to change tweet max length
// 10. create a constructor function to set an owner of contract
// 11. create a modifier called onlyOwner
// 12. only owners can change tweet length

// 13. add id to Tweet Struct to make every Tweet unique
// 14. set the id to be the Tweet[] length
// 15. 

contract Twitter {

    // define struct
    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        address author;
        string content;
        uint timestamp;
        uint likes;
    }

    mapping (address => Tweet[]) public tweets;
    address public owner;

    // this constructor is called exactly when the contract is deployed
    constructor() {
        owner = msg.sender; // the one tha creates the contract
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "YOU ARE NOT THE OWNER!");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweet) public {

        // if tweeth length <= 280 continue otherwise revert
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long bro!");

        Tweet memory newTeet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTeet);
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory ) {
        return tweets[_owner];
    }
}   
