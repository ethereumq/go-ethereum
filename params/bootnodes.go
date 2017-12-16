// Copyright 2015 The go-ethereum Authors
// This file is part of the go-ethereum library.
//
// The go-ethereum library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-ethereum library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-ethereum library. If not, see <http://www.gnu.org/licenses/>.

package params

// MainnetBootnodes are the enode URLs of the P2P bootstrap nodes running on
// the main  Ethereum Quantum network.
var MainnetBootnodes = []string{
    "enode://4dd2f4036a90b6383f9427809e16561b5098bea26b348e201e0efbc357e46dad0a472fa573ab17692676a34a5cf598f742cf2a4ca1df793f9bd15e18ec62f9ee@34.233.99.171:40303",
	//  Ethereum Quantum Foundation Go Bootnodes
}

// TestnetBootnodes are the enode URLs of the P2P bootstrap nodes running on the
// Ropsten test network.
var TestnetBootnodes = []string{
    "enode://7b592dda154ce631f2eee6ecc649fbecac9a768423c6c92e53c8cd8c9ffd5ed4829019fba46b254b4f70210a8b4eed3e898a890b83f7df6bef46fc9e51787011@52.4.44.79:40303",

}


// DiscoveryV5Bootnodes are the enode URLs of the P2P bootstrap nodes for the
// experimental RLPx v5 topic-discovery network.
var DiscoveryV5Bootnodes = []string{

}
