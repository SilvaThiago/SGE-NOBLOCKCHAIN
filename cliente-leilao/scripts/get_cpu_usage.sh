#!/bin/sh

while (true); do
	top -b -n 1 | grep "%Cpu(s)" | awk '{print $2}' >> hw_info/cpu_usage_$1
done