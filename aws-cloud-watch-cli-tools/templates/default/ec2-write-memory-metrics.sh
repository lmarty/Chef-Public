#!/bin/bash -l
#get instance id - used for putting metric
INSTANCE_ID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
INSTANCE_AZ=`curl -s curl http://169.254.169.254/latest/meta-data/placement/availability-zone/`
INSTANCE_REGION=${INSTANCE_AZ%?}

#could be done using "free" or "vmstat" - use of less and grep is believed to provide widest compatibility - CJ 2011-11-24
memactive=`cat /proc/meminfo | grep -i Active | head -1 | grep -o "[0-9]*"`
memtotal=`cat /proc/meminfo | grep -i MemTotal | grep -o "[0-9]*"`
memfree=$(($memtotal-$memactive))
swaptotal=`cat /proc/meminfo | grep -i SwapTotal | grep -o "[0-9]*"`
swapfree=`cat /proc/meminfo | grep -i SwapFree | grep -o "[0-9]*"`
swapused=$(($swaptotal-$swapfree))
memused=$((100-$memfree*100/$memtotal))
memfree_mb=$(($memfree/1024))
swapused_mb=$(($swapused/1024))

#mon-put-data to put metrics
mon-put-data --region $INSTANCE_REGION --metric-name MemoryFree --namespace EC2/Memory --value $memfree_mb --unit Megabytes --dimensions "InstanceId=$INSTANCE_ID"
mon-put-data --region $INSTANCE_REGION --metric-name MemoryUsed --namespace EC2/Memory --value $memused --unit Percent --dimensions "InstanceId=$INSTANCE_ID"
mon-put-data --region $INSTANCE_REGION --metric-name SwapUsed --namespace EC2/Memory --value $swapused_mb --unit Megabytes --dimensions "InstanceId=$INSTANCE_ID"
