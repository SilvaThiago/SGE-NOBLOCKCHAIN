#!/bin/sh

while (true); do
	nvidia-smi | grep % | awk '{print $3}' | cut -d'C' -f 1 >> hw_info$2/gpu_temp_$1
done