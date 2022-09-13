[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![CI](https://github.com/ethicnology/subterfuge/actions/workflows/build.yaml/badge.svg)](https://github.com/ethicnology/subterfuge/actions/workflows/build.yaml)

# subterfuge

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/subterfuge)

A Shamir secret sharing experience using SLIP39 implementation.

## About

Adi Shamir published [How to Share a Secret](https://dl.acm.org/doi/pdf/10.1145/359168.359176) in november 1979.  
Decades later, with the boom of cryptocurrencies, Shamir secret sharing resurface.  
How to deal with private keys belonging to a group instead of individual such as non-profit organizations and companies…  
In his scientific publication Shamir presents a threshold schemes ideally suited to applications in which a group of mutually suspicious individuals with conflicting interests must cooperate. Ideally, we would like the cooperation to be based on mutual consent.
Satoshi Lab Improvement Proposal n°39 or [SLIP39](https://github.com/satoshilabs/slips/blob/master/slip-0039.md) is the document that formalize Shamir's Secret Sharing for [Mnemonic Codes](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki), a group of easy to remember words which are widespread to back up secret keys.  
This application is an attempt to implement SLIP39 in [Flutter](https://flutter.dev/), an open source framework by Google for building natively compiled, multi-platform (**Linux, Web, Android, Windows, MacOs, iOs**) applications from a single codebase.

## Disclaimer

Please verify that your shares works by recovering your secret before using them.  

This application relies on [slip39-dart](https://github.com/ilap/slip39-dart) **as this dependency is flagged as early development phase, use it at your own risk**, please consider supporting [ilap](https://github.com/ilap) works.

## Usage

These methods avoid keeping a single point of failure for your secrets (keys).

### Backup

Keeping a secret safe is hard, subterfuge can help you to setup a scheme of 5 parts/shares which require a threshold of 3 parts/shares to recover the original secret. Then you can disperse these parts/shares in different locations.  

### Organizations

Managing the access of services, machines, documents by shared secret scheme of many individuals with the needed threshold.

### Legacy

Your secret securing documents and funds that you want to bequeath your relatives to access in case of death…

## Support my work

```sh
bitcoin: bc1qyhzq7twqz087ledn4zpz0xhxx23t5aa8s395nn
paypal:  ethicnology@pm.me
```

## Screenshots

![home](https://github.com/ethicnology/subterfuge/blob/main/assets/home.png)
![create](https://github.com/ethicnology/subterfuge/blob/main/assets/create_secret.png)
![shares](https://github.com/ethicnology/subterfuge/blob/main/assets/shares.png)
![recover](https://github.com/ethicnology/subterfuge/blob/main/assets/recover_secret.png)
![secret](https://github.com/ethicnology/subterfuge/blob/main/assets/secret.png)
![disclaimer](https://github.com/ethicnology/subterfuge/blob/main/assets/disclaimer.png)

### dataset

secret

```sh
fac4167d1e712b0065f563e88a5d365df95368072c42e8c306cff568cb6e1080
```

passphrase

```sh
r0bust
```

shares

```sh
treat leader adjust academic alpha fused clinic slap cinema moisture stay ticket holy revenue triumph database wireless keyboard much triumph listen jerky ancestor belong credit perfect enemy pharmacy hush genius juice jacket very

treat leader chemical academic already hearing friar elite shame aviation clinic morning enjoy clothes hush wealthy voter public recover edge spend jewelry chubby marathon velvet much dominant violence response prayer pecan reject cowboy

treat leader elder academic antenna costume fridge have amuse warn element wildlife sugar deal answer exotic flame saver race brother forget smear woman blue eyebrow arcade average walnut receiver craft railroad glen amount
```
