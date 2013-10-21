package WebService::TaobaoIP;

use Moo;
use utf8;
use Carp;
use JSON::XS;
use LWP::UserAgent;

# ABSTRACT: Perl interface to Taobao IP API
# VERSION

binmode STDOUT, ':encoding(UTF8)';

has 'ip' => ( is => 'rw', required => 1 );
has 'country' => ( is => 'ro' );
has 'area'    => ( is => 'ro' );
has 'region'  => ( is => 'ro' );
has 'city'    => ( is => 'ro' );
has 'isp'     => ( is => 'ro' );

sub BUILDARGS
{
    my ( $class, @args ) = @_;

    unshift @args, 'ip' if @args % 2 == 1;

    return {@args};
}

sub BUILD
{
    my $self = shift;

    my $base_url = 'http://ip.taobao.com/service/getIpInfo.php?ip=';
    my $full_url = $base_url . $self->ip;

    my $ua  = LWP::UserAgent->new;
    my $res = $ua->get($full_url);

    if ( $res->is_success )
    {
        my $info = JSON::XS->new->decode( $res->content );
        $info->{code} == 0
            ? %$self
            = %{ $info->{data} }
            : croak "$self->ip: get information failed.";
    }
    else
    {
        croak $res->status_line;
    }
}

1;

__END__

=head1 NAME

WebService::TaobaoIP - Perl interface to Taobao IP API

=head1 VERSION

Version 0.03

=head1 SYNOPSIS

    use WebService::TaobaoIP;

    my $ti = WebService::TaobaoIP->new('123.123.123.123');

    print $ti->ip;
    print $ti->country;
    print $ti->area;
    print $ti->region;
    print $ti->city;
    print $ti->isp;

=head1 DESCRIPTION

The WebService::TaobaoIP is a class implementing Taobao IP API. With it, you can get IP location information.

=head1 CONSTRUCTOR METHODS

=head2 $ti = WebService::TaobaoIP->new($ip)

This method constructs a new WebService::TaobaoIP object. You need to provide $ip argment.

=head1 ATTRIBUTES

The following attribute methods are provided.

=head2 $ti->ip

Return IP address.

=head2 $ti->country

Return country.

=head2 $ti->area

Return area.

=head2 $ti->region

Return region.

=head2 $ti->city

Return city.

=head2 $ti->isp

Return ISP.

=head1 AUTHOR

Xiaodong Xu, C<< <xxdlhy at gmail.com> >>

=head1 COPYRIGHT

Copyright 2013 Xiaodong Xu.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
