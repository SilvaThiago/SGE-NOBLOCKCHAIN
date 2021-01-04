#!/bin/sh

node /home/thiago/Documentos/Coding/Truffle/desenv-node/Leilao/app.js &

sleep 10


QTD_TEST=100;
QTDACCOUNTS=2;

for i in 2; do
	QTDACCOUNTS=$i;
	mkdir "$QTDACCOUNTS"usr_"$QTD_TEST"exe
	for counter in $(seq 0 $(echo $QTDACCOUNTS-1 | bc)); do
		./script.sh 0$counter $QTDACCOUNTS &
	done
done
