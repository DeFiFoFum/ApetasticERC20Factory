const ApetasticERC20Factory = artifacts.require("ApetasticERC20Factory");
const ApetasticERC20 = artifacts.require("ApetasticERC20");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(ApetasticERC20Factory);
  // Deploy a dummy ERC20 contract for verification purposes
  await deployer.deploy(ApetasticERC20, 'DUMMY', 'DUMMY', accounts[0], 1);
};
