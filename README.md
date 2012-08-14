mop
===

Make OK for Public - Hide usernames, passwords, hostnames, IPs, (what else), in preparation of a gist or other sharing? [Maturity: New]

Usage
-----

Builds on top of ConradIrwin's `jist` gem, so that you can more safely gist
files that have sensitive information.

Be aware that this is in its infancy, but even when fully-grown, it will never
replace thinking. It's merely a tool to help you get a jumpstart on sanitizing
a file.

Currently Works With
--------------------

- Passwords
  - `"password: secr3t"` ⇒ `"password: hiddenpass"`
  - `"password:   secr3t"` ⇒ `"password:   hiddenpass"`
  - `"password:\n\tsecr3t"` ⇒ `"password:\n\thiddenpass"`
  - `"password: 'secr3t'"` ⇒ `"password: hiddenpass"`
  - `"password:secr3t"` ⇒ `"password:hiddenpass"`
  - `"passwd:secr3t"` ⇒ `"passwd:hiddenpass"`
  - `"passwd: secr3t"` ⇒ `"passwd: hiddenpass"`
  - `"password=secr3t"` ⇒ `"password=hiddenpass"`
  - `"passwd=secr3t"` ⇒ `"passwd=hiddenpass"`
  - `"password=\"secr3t\""` ⇒ `"password=hiddenpass"`
  - `"buzbuz password: secr3t bizbiz"` ⇒ `"buzbuz password: hiddenpass bizbiz"`
  - `"buzbuz password: secr3t bizbiz another password: secr3t bazbaz"` ⇒ `"buzbuz password: hiddenpass bizbiz another password: hiddenpass bazbaz"`
  - `"password=secr3t"` ⇒ `"password=hiddenpass"`
  - `"passwd=secr3t"` ⇒ `"passwd=hiddenpass"`
  - `"USER: user55 PASS: secr3t"` ⇒ `"USER: user55 PASS: hiddenpass"`
  - `"U/N: user55 P/W: secr3t"` ⇒ `"U/N: hiddenuser P/W: hiddenpass"`
  - `"U: user55 P: secr3t"` ⇒ `"U: hiddenuser P: hiddenpass"`
  - `"U=user55 P=secr3t"` ⇒ `"U=hiddenuser P=hiddenpass"`
  - `"u=user55 p=secr3t"` ⇒ `"u=hiddenuser p=hiddenpass"`
  - `"u: user55 p: secr3t"` ⇒ `"u: hiddenuser p: hiddenpass"`
  - `"L=user55 P=secr3t"` ⇒ `"L=hiddenuser P=hiddenpass"`
- Addresses
  - `"1.2.3.4"` ⇒ `"hiddenaddress"`
  - `"asdf 1.2.3.4 asdf"` ⇒ `"asdf hiddenaddress asdf"`
  - `"1.2.3.4:22"` ⇒ `"hiddenaddress:22"`
  - `"123.45.67.89"` ⇒ `"hiddenaddress"`
  - `"0.0.0.0"` _(unchanged)_
  - `"127.0.0.1"` _(unchanged)_
- Capistrano's `deploy.rb`
  - `"host_name: 'shouldhide'"` ⇒ `"host_name: caphidden"`
  - `"host_name: \"shouldhide\""` ⇒ `"host_name: caphidden"`
  - `":host_name => 'shouldhide'"` ⇒ `":host_name => caphidden"`
  - `":host_name, 'shouldhide'"` ⇒ `":host_name, caphidden"`
  - `":port => 'shouldhide'"` ⇒ `":port => caphidden"`
  - `"deploy_to, 'shouldhide'"` ⇒ `"deploy_to, caphidden"`
  - `"server 'shouldhide'"` ⇒ `"server caphidden"`
- /etc/passwd having "fakeuser" and "fakeuser2"
  - `"foo bar fakeuser baz"` ⇒ `"foo bar hiddenuser baz"`
  - `"~/fakeuser"` ⇒ `"~/hiddenuser"`
  - `"/home/fakeuser/.foo"` ⇒ `"/home/hiddenuser/.foo"`
  - `"fakeuser2"` ⇒ `"hiddenuser"`


TODO
----

- Usernames hidden
    - Guess based on `/home/*`
- IP Addresses
    - IPv4
    - IPv6
- Hostnames
    - Dorky ISP-given ones that show IP addresses
    - `$HOST`

- Make distinct
  - first.host.name ⇒ hiddenhostname1
  - second.host.name ⇒ hiddenhostname2
