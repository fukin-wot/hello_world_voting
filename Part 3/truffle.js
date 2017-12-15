// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*',
      gas: 4500000
    },
    rinkeby: {
      host: "localhost",
      port: 8545,
      network_id: 4,
      from: "0xBE84Ac92C3a4827d9a3326faBee78eaD50C68aB8",
      gas: 4612388,
    }
  }
}
