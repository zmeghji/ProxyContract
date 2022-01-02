const Dogs = artifacts.require("Dogs");
const DogsUpdated = artifacts.require("DogsUpdated");
const Proxy = artifacts.require("Proxy");


module.exports = async function (deployer, network, accounts) {

    //deploy contracts;
    await deployer.deploy(Dogs);
    dogs = await Dogs.deployed();
    await deployer.deploy(Proxy, dogs.address);
    proxy = await Proxy.deployed();

    //fools truffle into thinking proxy contract has the same functions as dogs contract
    var proxyDog = await Dogs.at(proxy.address)

    //test
    await proxyDog.setNumberOfDogs(10);
    var numberOfDogs = await proxyDog.getNumberOfDogs();
    console.log("number of dogs: "+ numberOfDogs)

    //Deploy updated dogs contract
    await deployer.deploy(DogsUpdated);
    dogsUpdated = await DogsUpdated.deployed();

    //change proxy to use upgraded dogs contract
    proxy.upgrade(dogsUpdated.address);

    //
    proxyDog = await DogsUpdated.at(proxy.address)
    proxyDog.initialize((accounts[0]));

    //verify that the storage has the same value for dogs
    numberOfDogs = await proxyDog.getNumberOfDogs();
    console.log("number of dogs: "+ numberOfDogs)

    await proxyDog.setNumberOfDogs(5);

    //verify that the number of dogs has changed
    numberOfDogs = await proxyDog.getNumberOfDogs();
    console.log("number of dogs: "+ numberOfDogs)

};
