 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract JeuCartes is ERC721, Ownable, VRFConsumerBase {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    uint256 public randomResult;
    
    enum Raretetype  {rarete1, rarete2, rarete3, rarete4, rarete5}
    enum Position {Avant, Arriere} 0-> Avant, 1-> Arriere
   
   struct Carte {
        string memory name;
        string memory team;
        uint8 endurance;
        uint8 vitesse;
        Raretetype raretetype;
        Position position;
        uint8 force;
    }

    mapping(uint256 => Carte) private _cartes;
    
     constructor(address owner)
         public ERC721("CarteRugby", "CRB")
    {
         transferOwnership(owner);
    }
   
    
    function random() internal returns (uint) {
    uint random = uint(keccak256(now, msg.sender, nonce)) % 100;
    nonce++;
    randomResult = random;
    return random;
    
} 
   
    function carte(address player, string memory _name, string memory _team, uint8 _endurance, uint8 _vitesse, uint8 _force, Position _position) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
    
       
        _cartes[newTokenId] = Carte(_name, _team, _endurance, _vitesse, 0, 0, _force);
         if (randomResult <= 80) {
            _cartes[newTokenId].raretetype = RareteTyoe.rarete1; 
        }
       else if (randomResult <= 90 && randomresult >=80) {
            _cartes[newTokenId].raretetype = Raretetype.rarete2; 
        }
        else if (randomResult <= 95 && randomResult >= 90) {
            _cartes[newTokenId].raretetype = Rretetype.rarete3; 
        }
        else if (randomResult <= 98 && randomResult >= 95 ) {
            _cartes[newTokenId].raretetype = Raretetype.rarete4; 
        }
        else {
            _cartes[newTokenId].raretetype = Raretetype.rarete5; 
        }
        if (_position = Position.Avant) {
             _cartes[newTokenId].position = 0; 
        } else 
             _cartes[newTokenId].position = 1; 
        _mint(player, newTokenId);
        return newTokenId;
    }

    function getCarteById(uint256 tokenId) public view returns (Carte memory) {
        require(_exists(tokenId), " query for nonexistent token");
        return _cartes[tokenId];
    }
}

