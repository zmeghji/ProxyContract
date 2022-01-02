const Dogs = artifacts.require("Dogs");
const Proxy = artifacts.require("Proxy");


module.exports = async function (deployer, network, accounts) {
    await deployer.deploy(Dogs);
    dogs = await Dogs.deployed();
    await deployer.deploy(Proxy, dogs.address);
    proxy = await Proxy.deployed();

    //fools truffle into thinking proxy contract has the same functions as dogs contract
    //otherwise can't directly execute functions like this in the test: proxy.getNumberOfDogs()
    var proxyDog = await Dogs.at(proxy.address)

    await proxyDog.setNumberOfDogs(10);
    var numberOfDogs = await proxyDog.getNumberOfDogs();
    console.log("number of dogs: "+ numberOfDogs)

};
