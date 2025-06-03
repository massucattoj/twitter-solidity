// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.30;


// - create a twitter contract
// - create a mapping between user and tweet
// - add function to create a tweet and save it in mapping
// - create a function to get tweet
// - add arrays of tweets
// - define a tweet structure (author, content, timestamp, likes)
// - add the struct to the array
// - use require to limit the length of the tweet to be only 280 characters 
// - add a function to change tweet max length
// - create a constructor function to set an owner of contract
// - create a modifier called onlyOwner
// - only owners can change tweet length

// LIKES
// - add id to Tweet Struct to make every Tweet unique
// - set the id to be the Tweet[] length
// - add a function to like the tweet
// - add a function to unlike the tweet
// - mark both functions external

// EVENTS
// - create an Event for creating the tweet
// - emit the Event in the creation of a tweet
// - create event for liking the tweet and emit that event

// LOOPS
// - Create a function, to get total Tweet likes for the user
// - Loop over all the tweets
// - Sum the totalLikes
// - Return the total likes 

// INHERITANCE
// - Import Ownable.sol contract from OpenZeppelin
// - Inherit Ownable Contract
// - Replace current onlyOwner

// Contract to Contract
// - add a getProfile() function to the interface
// - initialize the IProfile constructor
// - create a modifier called onlyRegistered that require the msg.sender
// - add the onlyRegistered modified to create like and unlike a tweet

interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    }

    function getProfile(address _user) external view returns (UserProfile memory);
}

contract Twitter is Ownable {
    // Need to add that to initialize the Ownable
    IProfile profileContract;
    
    constructor(address _profileContract) Ownable(msg.sender) {
        profileContract = IProfile(_profileContract);
    }

    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint likes;
    }

    mapping (address => Tweet[]) public tweets;
    // address public owner;
    
    //Events
    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

    // Modifiers
    // modifier onlyOwner() {
    //     require(msg.sender == owner, "YOU ARE NOT THE OWNER!");
    //     _;
    // }
    modifier onlyRegistered(){
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(userProfileTemp.displayName).length > 0, "USER NOT REGISTERED");
        _;
    }

    // Functions
    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function getTotalLikes(address _author) external view returns(uint) {
        uint totalLikes;

        require ( tweets[_author].length > 0, "TWEET HAS NO LIKES");

        for( uint i= 0; i < tweets[_author].length; i++) {
            totalLikes += tweets[_author][i].likes;
        }

        return totalLikes;
    }

    function createTweet(string memory _tweet) public onlyRegistered {

        // if tweeth length <= 280 continue otherwise revert
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long bro!");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    // external, since will never be used inside the contract
    function likeTweet(address author, uint256 id) external  onlyRegistered {  
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");

        tweets[author][id].likes++;

        // Emit the TweetLiked event
        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external  onlyRegistered {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");
        require(tweets[author][id].likes > 0, "TWEET HAS NO LIKES");
        
        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes );
    }

    function getTweet( uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory ){
        return tweets[_owner];
    }
}   
