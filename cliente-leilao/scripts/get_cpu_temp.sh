#!/bin/sh

while (true); do
	sensors | grep CPU | awk '{print $2}' | cut -d'.' -f 1 | cut -d'+' -f 2 >> hw_info/cpu_temp_$1
done