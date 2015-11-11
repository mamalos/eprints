#define local fields
my $local_fields = [
{
	name => 'ml_title',
	type => 'multilang',
    multiple => 1,
    fields => [ { sub_name => "text", type => "longtext", input_rows => 3, make_single_value_orderkey => 'EPrints::Extras::english_title_orderkey' } ],
    input_add_boxes => 1,
},

{
	name => 'title',
    type => 'virtualwithvalue',
    virtual => 1,

#    get_value => sub
#    {
#        my ($eprint) = @_;
#        if ($eprint->is_set('ml_title'))
#        {
#            my $lang = $eprint->repository->get_langid;
#            # if cannot find a user language setting, I'm taking the default one
#            if (!$lang)
#            {
#                $lang = $c->{defaultlanguage};
#            }
#            my $vals = $eprint->get_value('ml_title');
#            my $title = '';
#            # set the default lang's text as title
#            foreach my $v1 (@{$vals})
#            {
#                if ($v1->{lang} eq $lang)
#                {
#                    $title = $v1->{text};
#                }
#            }
#            # if I couldn't find a title in the user's language, get the first object's text as title
#            if ($title eq '')
#            {
#                $title = $vals->[0]->{text};
#            }
#            return $title;
#
#        }
#        return undef;
#    },

    get_value => sub
    {
        my ($eprint) = @_;
        if ($eprint->is_set('ml_title'))
        {
            my $lang = $eprint->repository->get_langid;
            my $lang_set = 0;
            my $vals = $eprint->get_value('ml_title');
            my $title = '';
            if (!$lang)
            {
                $lang_set = 1;
            } 
            else
            {
                # set the default lang's text as title
                foreach my $v1 (@{$vals})
                {
                    if ($v1->{lang} eq $lang)
                    {
                        $title = $v1->{text};
                    }
                }
            }
            # if the language is not set or I can't find an abstract in the 
            # user's language, get the first object's text as abstract
            if ($lang_set or $title eq '')
            {
                $title = $vals->[0]->{text};
            }
            return $title;

        }
        return undef;
    },

#    set_value => sub
#    {
#        my ($eprint, $value) = @_;
#
#        my $lang = $eprint->repository->get_langid;
#        if (!$lang)
#        {
#           $lang = $c->{defaultlanguage};
#        }
#        #only use this on imports, NOT if the value is already set
#        if ($eprint->is_set('ml_title'))
#        {
#            return;
#        }
#        if ($value)
#        {
#            $eprint->set_value('ml_title', [{lang=>$lang, text=>$value}]);
#        }
#    }

    set_value => sub
    {
        my ($eprint, $value) = @_;
        my $lang = 'en';
        #only use this on imports, NOT if the value is already set
        if ($eprint->is_set('ml_title'))
        {
            return;
        }
        if ($value)
        {
            $eprint->set_value('ml_title', [{lang=>$lang, text=>$value}]);
        }
    }

},

{
	name => 'ml_abstract',
	type => 'multilang',
    multiple => 1,
    fields => [ { sub_name => "text", type => "longtext", input_rows => 10 } ],
    input_add_boxes => 1,
},

{
    name => 'abstract',
    type => 'virtualwithvalue',
    virtual => 1,

#    get_value => sub
#    {
#        my ($eprint) = @_;
#        if ($eprint->is_set('ml_abstract'))
#        {
#            my $lang = $eprint->repository->get_langid;
#            # if cannot find a user language setting, I'm taking the default one
#            if (!$lang)
#            {
#                $lang = $c->{defaultlanguage};
#            }
#            my $vals = $eprint->get_value('ml_abstract');
#            my $abstract = '';
#            # set the default lang's text as abstract
#            foreach my $v1 (@{$vals})
#            {
#                if ($v1->{lang} eq $lang)
#                {
#                    $abstract = $v1->{text};
#                }
#            }
#            # if I couldn't find a abstract in the user's language, get the first object's text as abstract
#            if ($abstract eq '')
#            {
#                $abstract = $vals->[0]->{text};
#            }
#            return $abstract;
#
#        }
#        return undef;
#    },

    get_value => sub
    {
        my ($eprint) = @_;
        if ($eprint->is_set('ml_abstract'))
        {
            my $lang = $eprint->repository->get_langid;
            my $lang_set = 0;
            my $vals = $eprint->get_value('ml_abstract');
            my $abstract = '';
            # if cannot find a user language setting, I'm taking the default one
            if (!$lang)
            {
                $lang_set = 1;
            }
            else
            {
                # set the default lang's text as abstract
                foreach my $v1 (@{$vals})
                {
                    if ($v1->{lang} eq $lang)
                    {
                        $abstract = $v1->{text};
                    }
                }
            }
            # if the language is not set or I can't find an abstract in the 
            # user's language, get the first object's text as abstract
            if ($lang_set or $abstract eq '')
            {
                $abstract = $vals->[0]->{text};
            }
            return $abstract;

        }
        return undef;
    },


#    set_value => sub
#    {
#        my ($eprint, $value) = @_;
#
#        my $lang = $eprint->repository->get_langid;
#        if (!$lang)
#        {
#           $lang = $c->{defaultlanguage};
#        }
#        #only use this on imports, NOT if the value is already set
#        if ($eprint->is_set('ml_abstract'))
#        {
#            return;
#        }
#        if ($value)
#        {
#            $eprint->set_value('ml_abstract', [{lang=>$lang, text=>$value}]);
#        }
#    }

    set_value => sub
    {
        my ($eprint, $value) = @_;
        my $lang = 'en';
        #only use this on imports, NOT if the value is already set
        if ($eprint->is_set('ml_abstract'))
        {
            return;
        }
        if ($value)
        {
            $eprint->set_value('ml_abstract', [{lang=>$lang, text=>$value}]);
        }
    }
},

];


#create lookup hash of local field names
my $local_fieldnames = {};

foreach my $f (@{$local_fields})
{
    $local_fieldnames->{$f->{name}} = 1;
}

#merge in existing field configurations
foreach my $f (@{$c->{fields}->{eprint}})
{
    if (!$local_fieldnames->{$f->{name}})
    {
     push @{$local_fields}, $f;
    }
}



#overwrite original array of configured fields
$c->{fields}->{eprint} = $local_fields;
