# EVM address helper scripts

[![MIT License](https://img.shields.io/badge/license-MIT-green)](/LICENSE)

Helper shells scripts for converting public keys to EVM addresses.

## Use case

I was building a solution on AWS, delegating EVM transaction signing to a singer
which used [secp256k1](https://en.bitcoin.it/wiki/Secp256k1) elliptic curve key
pairs, generated with [AWS KMS](https://aws.amazon.com/kms) for signing.

Once created, the private key sits on an HSM device, over which KMS provides an
abstraction. It never leaves the HSM unencrypted. The publilc key can be
downloaded in PEM format.

I needed to derive the account address from the PEM file.

### What key?

I'm not going to go into the details on KMS here. Suffice to say, if you want to
create a KMS key, which is going to be suitable for signing and verification of
EVM transactions on execution layer, you need to:

1. Go to AWS Console
2. Go to KMS
3. Go to "Customer managed keys"
4. Click "Create key"
5. Choose key type: "Asymmetric"
6. Choose key usage: "Sign and verify"
7. Choose key spec: "`ECC_SECG_P256K1`"

The rest is entirely up to you, depending on the intended use case. Be sure to
set the key policy follwing the least access principle.

## Solution

I wrote two scripts, one representing the public key in hex format (discarding
the EC `0x04` prefix) and another one calculating the account address from it.

I didn't want to use JS, TS or Python, as these are simple operations which can
be performed using shell script. And I wanted to use shell script for
portability (you're going to need to install `sha3sum` package though).

### Dependencies

Since you need to compute the **Keccak256** sum, the script calculating an EVM
address requires `keccak-256sum` command, which is not available out of the box
(checked macOS and Arch Linux), which is not ideal. You're going to need to
install `sha3sum` package, which provides `keccak-256sum`.

## Usage

Both scripts are simple and created with input piping in mind. They can however
take files as input parameters.

If called without parameters, both scripts are going to wait for input on
`stdin`.

**NOTE**: These are simple helper scripts performing no input validation;
garbage in, garbage out.

### Get public key hex from PEM

```bash
./pem2pubhex.sh public_key.pem
```

Alternatively you can `cat` the public key and pipe it to the script

```bash
cat public_key.pem | ./pem2pubhex.sh
```

### Get the EVM account address from public key hex

```bash
./pubhex2evm.sh public_key_hex
```

Or

```bash
cat public_key_hex | ./pubhex2evm.sh
```

### Get EVM account address directly from PEM

```bash
cat public_key.pem | ./pem2pubhex.sh | ./pubhex2evm.sh
```
