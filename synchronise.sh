#!/bin/bash

PYBAYES_DIR="../pybayes"

pushd "${PYBAYES_DIR}"
rev=$(git describe)
popd

make -C "${PYBAYES_DIR}/doc/" clean
make -C "${PYBAYES_DIR}/doc/" html
make -C "${PYBAYES_DIR}/doc/" latexpdf
rsync -am -v --delete "${PYBAYES_DIR}/doc/_build/html/" \
	--exclude /.git --exclude /synchronise.sh --exclude README \
	--exclude /.nojekyll --exclude /.buildinfo \
	./
cp "${PYBAYES_DIR}/thesis/thesis.pdf" ./

git add .
git commit -a -m "synchronise.sh: regenerate documentation for PyBayes ${rev}"
git push
