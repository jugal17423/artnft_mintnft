// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIArtNFT {
    address public owner;
    uint256 public totalSupply;
    
    mapping(uint256 => address) public owners;
    mapping(uint256 => string) public tokenURIs;

    event Minted(uint256 indexed tokenId, address indexed owner, string tokenURI);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mint() external {
        totalSupply++;
        uint256 tokenId = totalSupply;
        owners[tokenId] = msg.sender;
        tokenURIs[tokenId] = generateMetadata(tokenId);

        emit Minted(tokenId, msg.sender, tokenURIs[tokenId]);
    }

    function generateMetadata(uint256 tokenId) internal pure returns (string memory) {
        return string(abi.encodePacked("https://aiartnft.com/metadata/", uint2str(tokenId)));
    }

    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        while (_i != 0) {
            length -= 1;
            bstr[length] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}
