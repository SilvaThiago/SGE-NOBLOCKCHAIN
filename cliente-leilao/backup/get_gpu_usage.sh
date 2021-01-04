#!/bin/sh

while (true); do
	nvidia-smi | grep % | awk '{print $13}' | cut -d'%' -f 1 >> hw_info$2/gpu_usage_$1
done