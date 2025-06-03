# 🐦 Twitter Smart Contract

A simple, decentralized Twitter-like application built with Solidity. Users can create tweets, like/unlike them, and fetch tweets by user. The contract also includes access control for managing platform-wide tweet constraints.


## 🚀 Features

- 📝 Post tweets with a configurable character limit (default: 280)
- ❤️ Like and Unlike tweets
- 🔍 View single tweets or all tweets by a user
- 🔐 Only registered users (via profile contract) can interact
- ⚙️ Owner-only access to adjust platform settings


## 🛠 Tech Stack

- **Solidity** `^0.8.0`
- **OpenZeppelin Contracts**
- Compatible with **Hardhat** or **Foundry**


## 🧱 Smart Contract Structure

### `struct Tweet`
Defines the structure of a tweet:
- `id` – Unique tweet ID (per user)
- `author` – Address of the tweet author
- `content` – The tweet text
- `timestamp` – When the tweet was created
- `likes` – Number of likes


## 📜 Functions

### ✅ Tweet Management

| Function | Description |
|---------|-------------|
| `createTweet(string _tweet)` | Creates a tweet if within character limit and user is registered |
| `getTweet(uint _i)` | Fetches the i-th tweet of the sender |
| `getAllTweets(address _owner)` | Fetches all tweets by a specific user address |

### ❤️ Likes

| Function | Description |
|---------|-------------|
| `likeTweet(address author, uint256 id)` | Like a specific tweet from another user |
| `unlikeTweet(address author, uint256 id)` | Unlike a tweet (if it has likes) |

### 📊 Analytics

| Function | Description |
|---------|-------------|
| `getTotalLikes(address author)` | Returns total likes across all tweets by a user |

### ⚙️ Owner-Only Admin

| Function | Description |
|----------|-------------|
| `changeTweetLength(uint16 newTweetLength)` | Update max allowed tweet length (default: 280) |

### 📣 Events

| Event | Description |
|-------|-------------|
| `TweetCreated(uint256 id, address author, string content, uint256 timestamp)` | Emitted when a tweet is created |
| `TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount)` | Emitted when a tweet is liked |
| `TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount)` | Emitted when a tweet is unliked |


## 🔐 Access Control

- Inherits from OpenZeppelin's `Ownable`
- Only the contract owner can modify `MAX_TWEET_LENGTH` using `changeTweetLength`
- Only registered users (those with a non-empty `displayName` in the `IProfile` contract) can:
  - Create tweets
  - Like tweets
  - Unlike tweets


## 🧪 Example Usage

```solidity
// Create a tweet
twitter.createTweet("Hello Web3!");

// Like a tweet
twitter.likeTweet(address_of_author, tweet_id);

// Get all tweets from a user
Tweet[] memory myTweets = twitter.getAllTweets(msg.sender);
```

## 📜 License  
This project is licensed under the MIT License.

## ✨ Author  
Built with ❤️ using Solidity.  
Feel free to contribute or fork the project!


https://www.youtube.com/watch?v=AYpftDFiIgk&t
