// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Blog {
    struct Post {
        uint256 id;
        address author;
        string title;
        string content;
        uint256 timestamp;
    }

    mapping(uint256 => Post) private posts;
    uint256 public postCount;

    event PostCreated(uint256 indexed id, address indexed author, string title, uint256 timestamp);

    function createPost(string memory _title, string memory _content) public {
        postCount++;
        posts[postCount] = Post(postCount, msg.sender, _title, _content, block.timestamp);
        emit PostCreated(postCount, msg.sender, _title, block.timestamp);
    }

    function getPost(uint256 _postId) public view returns (uint256 id, address author, string memory title, string memory content, uint256 timestamp) {
        require(_postId > 0 && _postId <= postCount, "Invalid post ID");
        Post storage post = posts[_postId];
        return (post.id, post.author, post.title, post.content, post.timestamp);
    }

    function getAllPosts() public view returns (Post[] memory) {
        Post[] memory allPosts = new Post[](postCount);
        for (uint256 i = 1; i <= postCount; i++) {
            Post storage post = posts[i];
            allPosts[i - 1] = post;
        }
        return allPosts;
    }
}
