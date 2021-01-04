#!/bin/sh

QTD_TEST=1


rm hw_info/hw_info.csv
for counter in $(seq 1 $QTD_TEST); do
	sed -i.bak s/,/\./g hw_info/cpu_usage_$counter
	sed -i.bak s/,/\./g hw_info/gpu_usage_$counter
done

rm hw_info/*.bak

printf "cpu_temp_treino, gpu_temp_treino, cpu_usage_treino, gpu_usage_treino\n" >> hw_info/hw_info.csv

for counter in $(seq 1 $QTD_TEST); do
	# Calculando media da temperatura da cpu no treino
	count=$(wc -l < hw_info/cpu_temp_$counter); total=0;
	for i in $( awk '{ print $1; }' hw_info/cpu_temp_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info/hw_info.csv

	# Calculando media da temperatura da gpu no treino
	count=$(wc -l < hw_info/gpu_temp_$counter); total=0;
	for i in $( awk '{ print $1; }' hw_info/gpu_temp_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info/hw_info.csv

	# Calculando media do uso da cpu no treino
	count=$(wc -l < hw_info/cpu_usage_$counter); total=0;
	for i in $( awk '{ print $1; }' hw_info/cpu_usage_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info/hw_info.csv

	# Calculando media do uso da gpu no treino
	count=$(wc -l < hw_info/gpu_usage_$counter); total=0;
	for i in $( awk '{ print $1; }' hw_info/gpu_usage_$counter ); do 
    	total=$(echo $total+$i | bc )
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info/hw_info.csv


done