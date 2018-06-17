#!/usr/bin/env awk

FNR > 1 {
  if (length($8) > 1 ||
      $2 !~ /[A-Za-z]+/ ||
      $3 !~ /[A-Za-z]+/ ||
      $1 !~ /^([1-9]|1[1-2]):[0-5][0-9]:[0-5][0-9]\ (AM|PM)$/) {
    print $0 > "error_cust_data.csv";
  }
}
