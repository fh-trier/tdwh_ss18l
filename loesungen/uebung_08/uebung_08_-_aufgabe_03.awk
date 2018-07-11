#!/bin/awk

BEGIN {
  # Set output field seperator
  OFS=",";
}

function changeTime(inTime){
  # Split inTime into an array
  split(inTime, vTime, ":")
  vHour = vTime[1];
  vMin = vTime[2];

  # Split vTime[3] into an array
  # to split between seconds and time interval
  split(vTime[3], vSecondOrTimeInterval, " " )
  vSec = vSecondOrTimeInterval[1];
  vTimeIntervall = vSecondOrTimeInterval[2];

  # Add 12 hours for a PM time interval
  if (vTimeIntervall == "PM"){
    vHour+= 12;
  }

  # return the new time format
  return vHour ":" vMin ":" vSec;
}

{
  # check constraints
  if (length($8) > 0 ||
    $2 !~ /[A-Za-z]+/ ||
    $3 !~ /[A-Za-z]+/ ||
    $1 !~ /^([1-9]|1[0-2]):[0-5][0-9]:[0-5][0-9]\ (AM|PM)$/) {
    # write line into file
    print $0 > "error_cust_data";
  }
  else {
    # overide old with new time format
    $1 = changeTime($1);

    # print line on stdout
    print $0;
  }

}