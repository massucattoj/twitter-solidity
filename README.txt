# 🐦 Twitter Smart Contract

A simple, decentralized Twitter-like application built with Solidity. Users can create tweets, like/unlike them, and fetch tweets by user. The contract also includes access control for managing platform-wide tweet constraints.

---

## 🚀 Features

- Post tweets with a character limit (default: 280)
- Like and unlike tweets
- View individual tweets and user tweet history
- Owner-controlled tweet length configuration

---

## 🧱 Smart Contract Structure

### `struct Tweet`
Defines the structure of a tweet:
- `id` – Unique tweet ID (per user)
- `author` – Address of the tweet author
- `content` – The tweet text
- `timestamp` – When the tweet was created
- `likes` – Number of likes

---

## 🛠 Functions

### ✅ Tweet Management

| Function | Description |
|---------|-------------|
| `createTweet(string memory _tweet)` | Creates a new tweet. Reverts if it exceeds `MAX_TWEET_LENGTH`. |
| `getTweet(uint _i)` | Returns the `i-th` tweet of the caller. |
| `getAllTweets(address _owner)` | Returns all tweets of a specific address. |

### ❤️ Likes

| Function | Description |
|---------|-------------|
| `likeTweet(address author, uint256 id)` | Likes a tweet by a specific author. |
| `unlikeTweet(address author, uint256 id)` | Unlikes a tweet, if liked. |

### ⚙️ Admin (Owner-only)

| Function | Description |
|----------|-------------|
| `changeTweetLength(uint16 newTweetLength)` | Updates the maximum tweet length. |
| `onlyOwner` | Modifier to restrict access to the contract owner. |

---

## 🔒 Access Control

- The contract deployer is automatically set as the `owner`.
- Only the owner can change the max tweet length via `changeTweetLength`.

---

## ⚠️ Requirements

- Tweets must not exceed `MAX_TWEET_LENGTH` (default: 280).
- Tweet ID is set based on the current number of tweets by the user.
- You can only unlike tweets with at least 1 like.

---

## 🧪 Example Usage

```solidity
// Create a tweet
twitter.createTweet("Hello Web3!");

// Like a tweet
twitter.likeTweet(address_of_author, tweet_id);

// Get all tweets from a user
Tweet[] memory myTweets = twitter.getAllTweets(msg.sender);

## 📜 License  
This project is licensed under the MIT License.

## ✨ Author  
Built with ❤️ using Solidity.  
Feel free to contribute or fork the project!


https://www.youtube.com/watch?v=AYpftDFiIgk&t