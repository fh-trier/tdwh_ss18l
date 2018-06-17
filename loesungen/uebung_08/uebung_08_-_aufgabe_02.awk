#!/usr/bin/env awk

FNR < 6 {
  print $0;
}

FNR >= 2{
  if (minCust > $5){
    minCust = $5;
  }
  sumBest += $6;
}

END{
  print "...";
  print "Anzahl-Kunden " FNR-1;
  print "Kleinster Kundenwert: " minCust;
  print "Summe Bestellungen: " sumBest;
  print "Durchschnitt Bestellungen: " sumBest/(FNR-1);
}