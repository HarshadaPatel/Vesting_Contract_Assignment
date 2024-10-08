// This script can be used to deploy the "Storage" contract using Web3 library.
// Please make sure to compile "./contracts/1_Storage.sol" file before running this script.
// And use Right click -> "Run" from context menu of the file to run the script. Shortcut: Ctrl+Shift+S

import { deploy } from './web3-lib'

(async () => {
  try {
    const result = await deploy('ERC20Mock', ["Test Token", "TT", 18, 1000000,"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"])
    console.log(`address: ${result.address}`)
  } catch (e) {
    console.log(e.message)
  }
})()