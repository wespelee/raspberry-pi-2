#!/bin/sh
declare -i make_start_sec=`date +%s`

sh build-ras.sh $@ 2>&1 | tee make.log 

# Record make end time
declare -i make_end_sec=`date +%s`
declare make_end_date=`date +%y%m%d_%H%M`

#Calculate total make time
declare -i make_total_sec=$(($make_end_sec-$make_start_sec))
declare -i make_display_min=$(($make_total_sec/60))
declare -i make_display_sec=$(($make_total_sec%60))

cat make.log | grep -i warning: > make-warning.log
declare -i warning_count=`cat make-warning.log | grep -c -i warning`
echo "====================" >> make-warning.log
echo "Total Warnings Count" >> make-warning.log
echo "$warning_count" >> make-warning.log
echo "====================" >> make-warning.log

cat make.log | grep -i error: > make-error.log
declare -i error_count=`cat make-error.log | grep -c -i error`
echo "==================" >> make-error.log
echo "Total Errors Count " >> make-error.log
echo "$error_count" >> make-error.log
echo "==================" >> make-error.log

echo ""
echo "================================================================"
printf "[$make_end_date] Total make time: [%d:%02d], %d warnings, %d errors.\n" $make_display_min $make_display_sec $warning_count $error_count
echo "================================================================"
                                                                                                                                                                                                                 


