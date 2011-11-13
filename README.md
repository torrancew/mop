sist
====

Selective information sanitizing tool - Gist with hidden usernames,
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

Nothing.

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
- Passwords
    - Things that match `/passw(or)?d\s?[=:]\s?\S*/i`
