#!/usr/bin/perl -p -i~
use strict; use warnings;
s{("(?:date|time)"=>)(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} [-+]\d{4}),}{$1"$2",}g;
s{("posts"=>\[)(<Post:)}{$1#$2}g;
s!, ("[^"\[\]\{\}]+"=>[[{])!,\n$1!g;
