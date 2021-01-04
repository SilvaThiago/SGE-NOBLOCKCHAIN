#!/bin/sh

while (true); do
	echo $(nvidia-smi | grep % | awk '{print $9*100}' | cut -d'M' -f 1) / $(nvidia-smi | grep % | awk '{print $11}' | cut -d'M' -f 1)  | bc -l >> hw_info$2/gpu_mem_$1
done