#!perl -wn -0

# perl cube-normalize.pl cube-normalize.ru > cube-normalize.pie

print "// Add this to RDFS rules\n";

s{# (.*)}{// $1}; # first line is comment
s{PREFIX (.*?):\s+<(.*)>}{Prefices\n\{\n  $1: $2\n\}\n\nRules\n\{
  Id: qbX_slice_observation_dataSet
    dataset qb:slice       slice
    slice   qb:observation obs
    ------------------------------
    obs     qb:dataSet     dataset
};
s{# (.*)\r\n}{my $a = $1; $a =~ tr{ }{_}; "  Id: qb2_$a"}ge;
s{INSERT \{(.*?)\} WHERE \{(.*?)\};?}{$2    --------------------------$1}gs;
s{\?}{}g;

s{^(\s+\w+\s+)(.+?) ?;\r\n\s+}{$1$2\n$1}gm;
s{\[\]}{blank}g;
s{\[(.+)\]}{struc\n    struc   $1}g;
s{\s*\.\r\n}{\n}gm;

s{ a }{ rdf:type }g;
s{(\w+:\w+)}{<$1>}g;

print;
print "}\n";
