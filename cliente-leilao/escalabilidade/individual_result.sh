#!/bin/sh

PATH_RESULTS="/home/thiago/Documentos/Coding/Truffle/desenv-node/cliente-leilao/";
QTD_TEST=100;
rm individual.csv;


printf "cpu_temp, gpu_temp, mem_usage, cpu_usage, gpu_usage\n" >> individual.csv

for QTDACCOUNTS in $1; do
	PATH_GERAL=$PATH_RESULTS$QTDACCOUNTS"usr_"$QTD_TEST"exe/";
	# echo $PATH_GERAL;

	for i in $(seq 2 $(echo $QTD_TEST+1 | bc)); do 
		cpu_temp=0; gpu_temp=0; mem_usage=0; cpu_usage=0; gpu_usage=0;

		for counter in $(seq 0 $(echo $QTDACCOUNTS-1 | bc)); do
			PATH_ATUAL=$PATH_GERAL"hw_info0"$counter"/";
			# echo $PATH_ATUAL;
	    	line=$(cat $PATH_ATUAL"hw_info0"$counter".csv" | awk "NR=="$i"{print}")

			# echo $line;
	    	temp=$(echo $line | awk '{print $1}' | cut -d',' -f 1)
	    	cpu_temp=$(echo $cpu_temp+$temp | bc )

	    	temp=$(echo $line | awk '{print $2}' | cut -d',' -f 1)
	    	gpu_temp=$(echo $gpu_temp+$temp | bc )

	    	temp=$(echo $line | awk '{print $3}' | cut -d',' -f 1)
	    	mem_usage=$(echo $mem_usage+$temp | bc )

	    	temp=$(echo $line | awk '{print $4}' | cut -d',' -f 1)
	    	cpu_usage=$(echo $cpu_usage+$temp | bc )

	    	temp=$(echo $line | awk '{print $5}' | cut -d',' -f 1)
	    	gpu_usage=$(echo $gpu_usage+$temp | bc )
	    done
	    printf "%f, " $(echo "scale=6; $cpu_temp / ($QTDACCOUNTS)" | bc) >> individual.csv;
	    printf "%f, " $(echo "scale=6; $gpu_temp / ($QTDACCOUNTS)" | bc) >> individual.csv;
	    printf "%f, " $(echo "scale=6; $mem_usage / ($QTDACCOUNTS)" | bc) >> individual.csv;
	    printf "%f, " $(echo "scale=6; $cpu_usage / ($QTDACCOUNTS)" | bc) >> individual.csv;
	    printf "%f\n" $(echo "scale=6; $gpu_usage / ($QTDACCOUNTS)" | bc) >> individual.csv;
	done

done
