#!/bin/sh

QTD_TEST=1


# rm result_time
# rm result_classify
# rm clean_result
rm -rd hw_info
mkdir hw_info

for counter in $(seq 1 $QTD_TEST); do
	node cliente-request.js >> hw_info/result_time;
	sleep 5	
done
# sed '/^Extracting/ d' < result_time > clean_result_time

for counter in $(seq 1 $QTD_TEST); do
	./get_gpu_temp.sh $counter &
	./get_gpu_usage.sh $counter &
	./get_cpu_temp.sh $counter &
	./get_cpu_usage.sh $counter &
	node cliente-request.js;
	$(ps -axf | grep ./get_gpu_temp | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep ./get_gpu_usage | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep ./get_cpu_temp | grep -v grep | awk '{print "kill " $1}')
	$(ps -axf | grep ./get_cpu_usage | grep -v grep | awk '{print "kill " $1}')
	sleep 5	
done

# for counter in $(seq 1 $QTD_TEST); do
# 	python3 classify.py >> result_classify;
# 	sleep 5
# done

# sed '/^Extracting/ d' < result_classify > clean_result_classify

# for counter in $(seq 1 $QTD_TEST); do
# 	./get_gpu_temp.sh classificacao $counter &
# 	./get_gpu_usage.sh classificacao $counter &
# 	./get_cpu_temp.sh classificacao $counter &
# 	./get_cpu_usage.sh classificacao $counter &
# 	python3 classify.py;
# 	$(ps -axf | grep ./get_gpu_temp | grep -v grep | awk '{print "kill " $1}')
# 	$(ps -axf | grep ./get_gpu_usage | grep -v grep | awk '{print "kill " $1}')
# 	$(ps -axf | grep ./get_cpu_temp | grep -v grep | awk '{print "kill " $1}')
# 	$(ps -axf | grep ./get_cpu_usage | grep -v grep | awk '{print "kill " $1}')
# 	sleep 5
# done

./get_hw_infos.sh