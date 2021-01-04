#!/bin/sh

QTD_TEST=$1


# rm hw_info$2/hw_info$2.csv
for counter in $(seq 1 $QTD_TEST); do
	sed -i.bak s/,/\./g $3/cpu_usage_$counter
	sed -i.bak s/,/\./g $3/gpu_usage_$counter
	sed -i.bak s/,/\./g $3/mem_usage_$counter
	sed -i.bak s/,/\./g $3/gpu_mem_$counter
done

rm $3/*.bak

printf "cpu_temp, gpu_temp, mem_usage, cpu_usage, gpu_usage\n" >> $3/hw_info$2.csv

for counter in $(seq 1 $QTD_TEST); do
	echo TESTE $2 $counter/$QTD_TEST;

	# Retirando valores N/A
	cat $3/cpu_temp_$counter | grep -v N/A > $3/cpu_temp_now;
	mv $3/cpu_temp_now $3/cpu_temp_$counter;
	# Calculando media da temperatura da cpu
	count=$(wc -l < $3/cpu_temp_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/cpu_temp_$counter ); do 
    	total=$(echo $total+$i | bc )

    	# contador=$(echo $contador+1 | bc )
    	# echo $(wc -l < $3/cpu_temp_$counter)
    	# echo $contador
    	# echo $counter
    	# echo $total
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media da temperatura da gpu
	count=$(wc -l < $3/gpu_temp_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/gpu_temp_$counter ); do 
    	total=$(echo $total+$i | bc )

    	# contador=$(echo $contador+1 | bc )
    	# echo $(wc -l < $3/gpu_temp_$counter)
    	# echo $contador
    	# echo $counter
    	# echo $i
    	# echo $total
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media do uso da memoria
	count=$(wc -l < $3/mem_usage_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/mem_usage_$counter ); do 
    	total=$(echo $total+$i | bc )

    	# contador=$(echo $contador+1 | bc )
    	# echo $(wc -l < $3/mem_usage_$counter)
    	# echo $contador
    	# echo $counter
    	# echo $i
    	# echo $total
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media do uso da cpu
	count=$(wc -l < $3/cpu_usage_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/cpu_usage_$counter ); do 
    	total=$(echo $total+$i | bc )

    	# contador=$(echo $contador+1 | bc )
    	# echo $(wc -l < $3/cpu_usage_$counter)
    	# echo $contador
    	# echo $counter
    	# echo $i
    	# echo $total
  	done	
  	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv

	# Calculando media do uso da gpu
	count=$(wc -l < $3/gpu_usage_$counter); total=0; contador=0;
	for i in $( awk '{ print $1; }' $3/gpu_usage_$counter ); do 
    	total=$(echo $total+$i | bc )

    	# contador=$(echo $contador+1 | bc )
    	# echo $(wc -l < $3/gpu_usage_$counter)
    	# echo $contador
    	# echo $counter
    	# echo $i
    	# echo $total
  	done	
  	printf "%f\n" $(echo "scale=6; $total / $count" | bc) >> $3/hw_info$2.csv


done






# printf "cpu_temp, gpu_temp, cpu_usage, gpu_usage, gpu_mem_usage, mem_usage\n" >> hw_info$2/hw_info$2.csv

# for counter in $(seq 1 $QTD_TEST); do
# 	echo TESTE $2 $counter/$QTD_TEST;

# 	# Retirando valores N/A
# 	cat hw_info$2/cpu_temp_$counter | grep -v N/A > hw_info$2/cpu_temp_now;
# 	mv hw_info$2/cpu_temp_now hw_info$2/cpu_temp_$counter;
# 	# Calculando media da temperatura da cpu
# 	count=$(wc -l < hw_info$2/cpu_temp_$counter); total=0;
# 	for i in $( awk '{ print $1; }' hw_info$2/cpu_temp_$counter ); do 
#     	total=$(echo $total+$i | bc )
#   	done	
#   	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info$2/hw_info$2.csv

# 	# Calculando media da temperatura da gpu
# 	count=$(wc -l < hw_info$2/gpu_temp_$counter); total=0;
# 	for i in $( awk '{ print $1; }' hw_info$2/gpu_temp_$counter ); do 
#     	total=$(echo $total+$i | bc )
#   	done	
#   	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info$2/hw_info$2.csv

# 	# Calculando media do uso da cpu
# 	count=$(wc -l < hw_info$2/cpu_usage_$counter); total=0;
# 	for i in $( awk '{ print $1; }' hw_info$2/cpu_usage_$counter ); do 
#     	total=$(echo $total+$i | bc )
#   	done	
#   	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info$2/hw_info$2.csv

# 	# Calculando media do uso da gpu
# 	count=$(wc -l < hw_info$2/gpu_usage_$counter); total=0;
# 	for i in $( awk '{ print $1; }' hw_info$2/gpu_usage_$counter ); do 
#     	total=$(echo $total+$i | bc )
#   	done	
#   	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info$2/hw_info$2.csv

# 	# Calculando media do uso da memória da gpu
# 	count=$(wc -l < hw_info$2/gpu_mem_$counter); total=0;
# 	for i in $( awk '{ print $1; }' hw_info$2/gpu_mem_$counter ); do 
#     	total=$(echo $total+$i | bc )
#   	done	
#   	printf "%f, " $(echo "scale=6; $total / $count" | bc) >> hw_info$2/hw_info$2.csv

# 	# Calculando media do uso da memoria
# 	count=$(wc -l < hw_info$2/mem_usage_$counter); total=0;
# 	for i in $( awk '{ print $1; }' hw_info$2/mem_usage_$counter ); do 
#     	total=$(echo $total+$i | bc )
#   	done	
#   	printf "%f\n" $(echo "scale=6; $total / $count" | bc) >> hw_info$2/hw_info$2.csv


# done