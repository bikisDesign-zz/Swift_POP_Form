#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

git submodule update --remote

jazzy --readme README.md -a 'Aaron Bikis' -g 'https://github.com/bikisDesign/Swift_POP_Form' -o docs/ -c true --source-directory Example/ -m Swift_POP_Form
