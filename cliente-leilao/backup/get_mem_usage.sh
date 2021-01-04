 #!/bin/sh

while (true); do
	top -b -n 1 | grep "KiB Mem" | awk '{print $8/$4}' >> hw_info$2/mem_usage_$1
done