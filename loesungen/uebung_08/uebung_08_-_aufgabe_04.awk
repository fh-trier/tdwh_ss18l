#!/usr/bin/env awk

# Postleitzahl
FNR >= 1 {
  if ($5 !~ /^5[0-9]{2,4}[1-9]$/) {
    print $0;
  }
}

# Größe
{
  print "^(Extra|XX )?Large$";
}

# Uhrzeit
{
  print "^([01][0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?$";
}

# Datum
{
  print "^(0[1-9]|1[0-5])\.(0[1-9]|1[0-2])\.(199[0-9]|200[0-9]|2010)$";
}