const ERC20 = artifacts.require('./ERC20.sol');

const expect = require('chai').expect;

contract('ERC20', function (accounts) {
  let erc20;

  const owner = accounts[0];

  beforeEach(async function () {
    erc20 = await ERC20.new(10e18);
  });

  it('should be initialized with the right total supply', async function () {
    let totalSupply = await erc20.totalSupply.call();
    expect(totalSupply.toString()).to.equal('10000000000000000000');
  });

  it('should be initialized with total supply for the owner', async function () {
    let balance = await erc20.balanceOf.call(owner);
    expect(balance.toString()).to.equal('10000000000000000000');
  });

  it('should be possible to transfer tokens', async function () {
    const receiver = accounts[1];
    await erc20.transfer(receiver, 42, { from: owner});
    let balance = await erc20.balanceOf.call(receiver);
    expect(balance.toString()).to.equal('42');
  });

  it('should be possible to set allowances', async function () {
    const spender = accounts[1];
    await erc20.allow(spender, 42, { from: owner});
    let allowance = await erc20.allowance.call(owner, spender);
    expect(allowance.toString()).to.equal('42');
  });
});
