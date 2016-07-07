#!/usr/bin/perl -I /usr/share/eprints3/perl_lib
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
		if($DEBUG) 
		{
	        print "item with id " . $d->id . " has already it's ml_title field set\n";
		}
    } else {
        if ($d->is_set('title'))
        {
            my $tit = $d->get_value('title');
            my @ml_tit = [ {lang=>'en', text=>$tit}, {lang=>'el', text=>$tit} ];
            $d->set_value('ml_title', @ml_tit);
            $d->commit();
        }
    }
    
}

