#!/usr/bin/env awk

BEGIN {
  OFS = ",";  # OutputFieldSeperator
}

FNR > 1{
  $2 = toupper(substr($2,1,1)) tolower(substr($2,2));
  $3 = toupper(substr($3,1,1)) tolower(substr($3,2));
  hour = substr($1, 1, match($1, /:/)-1);

  if($1 ~ /PM$/ && hour != 12) {
    $1 = hour + 12 substr($1, match($1,/:/), 6);
  }
  else if ($1 ~ /PM$/ && hour == 12) {
    $1 = 0 substr($1, match($1,/:/), 6);
  }
  else {
    $1 = substr($1,1,length($1)-3);
  }
}

{
  print $0;
}