var TimeForHack = artifacts.require("TimeForHack");
var Private_Bank = artifacts.require("Private_Bank");

module.exports = function(deployer) {
  deployer.deploy(TimeForHack);
  deployer.deploy(Private_Bank);
};
