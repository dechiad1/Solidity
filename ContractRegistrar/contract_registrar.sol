contract registrar {
  
  struct Contract {
    address[] versions;
    uint256 current_version;
    bool initialized;
  }
  
  mapping(string => Contract) contract_table;
  address owner;
  
  function registrar(address _owner) {
    owner = _owner;
  }
  
  //get current version
  function getCurrentContract(string name) constant returns(address version) {
    Contract _contract = contract_table[name];
    if(_contract.initialized) {
      uint256 _index = _contract.current_version;
      version = _contract.versions[_index];
    }
  }

  //allow the owner to update their endpoint
  function addVersion(string name, address version) {
    if(owner == msg.sender) {
      Contract _contract = contract_table[name];
      
      if(! _contract.initialized) {
        _contract.initialized = true;
        _contract.current_version = 0;
        _contract.versions.push(version);
        contract_table[name] = _contract;
      } else {
        _contract.versions.push(version);
        _contract.current_version = _contract.versions.length - 1;
        contract_table[name] = _contract;
      }
    }
  }

  //rollback to previous contract
  function rollbackVersion(string name, address version) {
    if(owner == msg.sender) {
      Contract _contract = contract_table[name];
      if(_contract.initialized) {
        for(uint256 index = 0; index < _contract.versions.length; index++) {
          if(_contract.versions[index] == version) {
            _contract.current_version = index;
          }
        }
      }
    }
  }
}
