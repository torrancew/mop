sist
====

Selective information sharing tool - Gist with hidden usernames,
passwords, hostnames, IPs, (what else)? [Maturity: New]

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
  - `"U/N: user55 P/W: secr3t"` ⇒ `"U/N:hiddenuser P/W:hiddenpass"`
  - `"U: user55 P: secr3t"` ⇒ `"U:hiddenuser P:hiddenpass"`
  - `"U=user55 P=secr3t"` ⇒ `"U=hiddenuser P=hiddenpass"`
  - `"u=user55 p=secr3t"` ⇒ `"u=hiddenuser p=hiddenpass"`
  - `"u: user55 p: secr3t"` ⇒ `"u:hiddenuser p:hiddenpass"`
  - `"L=user55 P=secr3t"` ⇒ `"L=hiddenuser P=hiddenpass"`
- Addresses
  - `"1.2.3.4"` ⇒ `"hiddenaddress"`
  - `"asdf 1.2.3.4 asdf"` ⇒ `"asdf hiddenaddress asdf"`
  - `"0.0.0.0"` _(unchanged)_
  - `"127.0.0.1"` _(unchanged)_


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
