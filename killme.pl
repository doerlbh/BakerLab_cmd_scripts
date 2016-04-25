#!/usr/bin/perl
my @process;
if($ARGV[0]){@process = `ps -u sunnylin -f | grep $ARGV[0] | grep -v PID | grep -v sshd | grep -v bash | grep -v killme`;}
else{@process = `ps -u sunnylin -f | grep -v PID | grep -v sshd | grep -v bash | grep -v killme`;}
foreach $p (@process)
{
	chomp($p);
	my @tmp = split(/ +/,$p);
	system("kill -9 $tmp[1]");
}
