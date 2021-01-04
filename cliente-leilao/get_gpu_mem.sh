#!/bin/sh

while (true); do
	line=$(echo "$(nvidia-smi|grep %)");
	mem_used=$(echo $line|grep %|awk '{print $9}'|cut -d'M' -f 1);
	mem_total=$(echo $line|grep %|awk '{print $11}'|cut -d'M' -f 1);
	echo "scale=6; $mem_used * 100 / $mem_total" | bc -l  >> hw_info$2/gpu_mem_$1
done