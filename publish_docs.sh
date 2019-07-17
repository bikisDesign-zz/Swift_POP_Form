#!/bin/bash
git add .
git commit -am "auto-update docs"
git subtree push --prefix docs origin gh-pages
git status