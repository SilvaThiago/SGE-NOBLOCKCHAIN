#!/bin/sh

QTD_TEST=100;
QTDACCOUNTS=$2;
PATH_HWINFO="$QTDACCOUNTS"usr_"$QTD_TEST"exe/hw_info$1;


# rm result_time
# rm result_classify
# rm clean_result
# rm -rd hw_info$1
# mkdir hw_info$1
mkdir $PATH_HWINFO

for counter in $(seq 1 $QTD_TEST); do
	node cliente-request.js >> "$PATH_HWINFO"/result_time;
	sleep 5	
done
# sed '/^Extracting/ d' < result_time > clean_result_time

for counter in $(seq 1 $QTD_TEST); do
	./get_gpu_temp.sh $counter $1 $PATH_HWINFO &
	./get_gpu_usage.sh $counter $1 $PATH_HWINFO &
	# ./get_gpu_mem.sh $counter $1 $PATH_HWINFO &
	./get_cpu_temp.sh $counter $1 $PATH_HWINFO &
	./get_cpu_usage.sh $counter $1 $PATH_HWINFO &
	./get_mem_usage.sh $counter $1 $PATH_HWINFO &
	node cliente-request.js;
	$(ps -axf | grep "./get_gpu_temp.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_gpu_usage.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	# $(ps -axf | grep "./get_gpu_mem.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_cpu_temp.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_cpu_usage.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep "./get_mem_usage.sh $counter $1 $PATH_HWINFO" | grep -v grep | awk '{print "kill " $1}')
	sleep 5	
done

./get_hw_infos.sh $QTD_TEST $1 $PATH_HWINFO