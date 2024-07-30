```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArtworkOwnership {
    struct Artwork {
        uint256 id;
        string title;
        address owner;
        mapping(address => bool) voters;
    }

    mapping(uint256 => Artwork) public artworks;
    uint256 public totalArtworks;

    // Event to log artwork creation
    event ArtworkCreated(uint256 id, string title, address owner);
    // Event to log ownership transfer
    event OwnershipTransferred(uint256 id, address previousOwner, address newOwner);
    // Event to log vote cast
    event VoteCast(uint256 id, address voter);

    // Function to create a new artwork
    function createArtwork(string memory _title) external {
        totalArtworks++;
        artworks[totalArtworks] = Artwork(totalArtworks, _title, msg.sender);
        emit ArtworkCreated(totalArtworks, _title, msg.sender);
    }

    // Function to transfer ownership of an artwork
    function transferOwnership(uint256 _id, address _newOwner) external {
        require(msg.sender == artworks[_id].owner, "Only the current owner can transfer ownership");
        artworks[_id].owner = _newOwner;
        emit OwnershipTransferred(_id, msg.sender, _newOwner);
    }

    // Function to vote for an artwork
    function voteForArtwork(uint256 _id) external {
        require(artworks[_id].owner != address(0), "Artwork does not exist");
        require(!artworks[_id].voters[msg.sender], "You have already voted for this artwork");
        artworks[_id].voters[msg.sender] = true;
        emit VoteCast(_id, msg.sender);
    }
}
