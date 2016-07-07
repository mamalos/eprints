#!/usr/bin/perl -I /usr/share/eprints3/perl_lib
# No liability for the contents of this document can be accepted. Use the 
# concepts, examples and information at your own risk. There may be errors, 
# omissions, and inaccuracies that could cause you to lose data, harm your 
# system, or induce involuntary electrocution, so proceed with appropriate 
# caution. The author takes no responsibility for any damages, incidental or 
# otherwise.

# This script copies the title field of each eprint in ml_title field. You can
# replace title with abstract and the same script will copy the contents of 
# the abstract field in ml_abstract.

# !!! WARNING !!!
# The values are copied in both en and el languages. Change this behaviour to
# reflect your own configuration.

use EPrints;
my $DEBUG = 0;
die "usage: $0 <reponame> [dataset]\n" if @ARGV < 1;

my $ep = EPrints->new();
my $reponame = $ARGV[0];
my $dataset = $ARGV[1];

if (!$dataset)
{
	my $dataset = "archive";
}

my $repo = $ep->repository( $reponame );
my $ds = $repo->dataset($dataset);
my @docs = $list->slice(0, $n);


foreach $d (@docs)
{
    if ($d->is_set('ml_title'))

    {
        print "item with id " . $d->id . " has already it's ml_title field set\n" if $DEBUG;
        next;
    }
    if (!$d->is_set('title'))

    {
        next;
    }
    my $tit = $d->get_value('title');
    my @ml_tit = [ {lang=>'en', text=>$tit}, {lang=>'el', text=>$tit} ];
    $d->set_value('ml_title', @ml_tit);
    $d->commit();
}
