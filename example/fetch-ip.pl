#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use lib '../lib';
use WebService::TaobaoIP;

my $ti = WebService::TaobaoIP->new('110.75.4.179');

my $ip      = $ti->ip;
my $country = $ti->country;
my $area    = $ti->area;
my $region  = $ti->region;
my $city    = $ti->city;
my $isp     = $ti->isp;

say $ip;
say $country;
say $area;
say $region;
say $city;
say $isp;
