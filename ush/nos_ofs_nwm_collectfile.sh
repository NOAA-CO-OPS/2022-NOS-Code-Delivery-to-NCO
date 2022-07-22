#!/bin/bash
#  command: nwm_collectfile.sh '202010190300' '202010230900'
# module load prod_util/1.1.4
# COMINnwm=${COMINnwm:-$(compath.py nwm/prod)}
set -x

OFS=$1
starttime=$2
endtime=$3

#  Provide fix directory path
# export FIXofs=/gpfs/dell2/nos/save/Lianyuan.Zheng/nwprod/nosofs.v3.2.4/fix/${OFS}

#  Search analysis NWM file
dstr=${starttime:0:8}
hstr=${starttime:8:2}:${starttime:10:2}:00
starttime=$( date -d "${dstr} ${hstr} 6 hours ago" +%Y%m%d%H%M )

if [ -f tmp_river.ctl ]; then
  rm -f tmp_river.ctl
fi
touch tmp_river.ctl

NWMfile=0
i=0
while [ "${thedate}" != "${endtime}" ]; do
  dstr=${starttime:0:8}
  hstr=${starttime:8:2}:${starttime:10:2}:00
  thedate=$( date -d "${dstr} ${hstr} ${i} hours" +%Y%m%d%H%M )
  YYNWM=${thedate:0:4}
  MMNWM=${thedate:4:2}
  DDNWM=${thedate:6:2}
  HHNWM=${thedate:8:2}
  nwm_dir=${COMINnwm}/nwm.${YYNWM}${MMNWM}${DDNWM}/analysis_assim
  nwmfile=${nwm_dir}/nwm.t${HHNWM}z.analysis_assim.channel_rt.tm02.conus.nc
  if [ -f ${nwmfile} ]; then
    echo ${nwmfile} >> tmp_river.ctl
    NWMfile=$(( NWMfile + 1 ))
  else
    dstr=${thedate:0:8}
    hstr=${thedate:8:2}:${thedate:10:2}:00
    thedate=$( date -d "${dstr} ${hstr} 1 hour ago" +%Y%m%d%H%M )
    YYNWM=${thedate:0:4}
    MMNWM=${thedate:4:2}
    DDNWM=${thedate:6:2}
    HHNWM=${thedate:8:2}
    nwm_dir=${COMINnwm}/nwm.${YYNWM}${MMNWM}${DDNWM}/analysis_assim
    nwmfile=${nwm_dir}/nwm.t${HHNWM}z.analysis_assim.channel_rt.tm01.conus.nc
    if [ -f ${nwmfile} ]; then
      echo ${nwmfile} >> tmp_river.ctl
      NWMfile=$(( NWMfile + 1 ))
    fi
    nwmfile=${nwm_dir}/nwm.t${HHNWM}z.analysis_assim.channel_rt.tm00.conus.nc
    if [ -f ${nwmfile} ]; then
      echo ${nwmfile} >> tmp_river.ctl
      NWMfile=$(( NWMfile + 1 ))
    fi
    break
  fi
  i=$(( i + 1 ))
done
#  End of searching Analysis NWM files

#  Search short-range NWM file
nwm_dir=${COMINnwm}/nwm.${YYNWM}${MMNWM}${DDNWM}/short_range
nwmfile=${nwm_dir}/nwm.t${HHNWM}z.short_range.channel_rt.f001.conus.nc
if [ -f ${nwmfile} ]; then
  for j in $(seq -f "%03g" 1 18); do
    nwmfile=${nwm_dir}/nwm.t${HHNWM}z.short_range.channel_rt.f${j}.conus.nc
    if [ -f ${nwmfile} ]; then
      echo ${nwmfile} >> tmp_river.ctl
      NWMfile=$(( NWMfile + 1 ))
    fi
  done
else
  dstr=${thedate:0:8}
  hstr=${thedate:8:2}:${thedate:10:2}:00
  thedate=$( date -d "${dstr} ${hstr} 1 hour ago" +%Y%m%d%H%M )
  YYNWM=${thedate:0:4}
  MMNWM=${thedate:4:2}
  DDNWM=${thedate:6:2}
  HHNWM=${thedate:8:2}
  nwm_dir=${COMINnwm}/nwm.${YYNWM}${MMNWM}${DDNWM}/short_range
  for j in $(seq -f "%03g" 1 18); do
    nwmfile=${nwm_dir}/nwm.t${HHNWM}z.short_range.channel_rt.f${j}.conus.nc
    if [ -f ${nwmfile} ]; then
      echo ${nwmfile} >> tmp_river.ctl
      NWMfile=$(( NWMfile + 1 ))
    fi
  done
fi
#  End of searching short-range NWM files

#  Search medium-range NWM file
#  Find the last NWM cycle which has NWM output
lastd=${endtime:0:8}
stard=${starttime:0:8}
thedate=${endtime:0:8}
day5ago=$( date -d "${stard:0:8} -3 day" +%Y%m%d )
ierr=0
while [ "${thedate}" != "${day5ago}" ]; do
  YYNWM=${thedate:0:4}
  MMNWM=${thedate:4:2}
  DDNWM=${thedate:6:2}
  nwm_dir=${COMINnwm}/nwm.${YYNWM}${MMNWM}${DDNWM}/medium_range_mem1
  for j in 18 12 06 00; do
    nwmfile=${nwm_dir}/nwm.t${j}z.medium_range.channel_rt_1.f003.conus.nc
    if [ -f ${nwmfile} ]; then
      for i in $(seq -f "%03g" 3 240); do
        nwmfile=${nwm_dir}/nwm.t${j}z.medium_range.channel_rt_1.f${i}.conus.nc
        if [ -f ${nwmfile} ]; then
          echo ${nwmfile} >> tmp_river.ctl
          NWMfile=$(( NWMfile + 1 ))
        fi
      done
      ierr=1
      break
    fi
  done

  if [ ${ierr} -eq 1 ]; then
    break
  else
    thedate=$( date -d "${thedate:0:8} -1 day" +%Y%m%d )
  fi
done
#  End of searching medium-range NWM file
  
if [ -f nwm_input.ctl ]; then
  \rm nwm_input.ctl
fi

touch nwm_input.ctl
echo ${OFS} >> nwm_input.ctl
echo ${NWMfile} >> nwm_input.ctl
cat tmp_river.ctl >> nwm_input.ctl
\rm tmp_river.ctl

#cp -p ${FIXofs}/${OFS}_rivstat.dat .
cp -p ${FIXofs}/nos.${OFS}*.river.index .

