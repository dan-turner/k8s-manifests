# Introduction

This repository provides a simple example of how to produce kubernetes resources in a templated way to support multiple environments using the templating language [Jinja2](http://jinja.pocoo.org/docs/2.10/api/)

Stuff that varies by environment should be defined in respective environments under [config](/config).
Kubernetes manifests under [src](/src) can then reference these variables using Jinja syntax as per the example

## Dependencies

* [Yasha](https://github.com/kblomqvist/yasha)

## Usage

`make test` or `make prod`
