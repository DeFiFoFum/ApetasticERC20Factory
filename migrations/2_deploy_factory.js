const ApetasticERC20Factory = artifacts.require("ApetasticERC20Factory");
const ERC20Initializable = artifacts.require("ERC20Initializable");

module.exports = async function (deployer) {
  await deployer.deploy(ApetasticERC20Factory);
  // Deploy a dummy ERC20 contract for verification purposes
  await deployer.deploy(ERC20Initializable);
};
