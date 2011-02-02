#!/bin/bash

pushd ../pybayes
rev=$(git describe)
popd

make -C ../pybayes/doc/ html
cp -r ../pybayes/doc/_build/html/* ./
git add .
git commit -m "synchronise.sh: regenerate documentation for PyBayes ${rev}"
git push
