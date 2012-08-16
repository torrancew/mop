class Mop
  IPv4_ADDRESSES = %r/((\d+\.){3}\d+)/
  HEXDIGIT = %r/[a-z0-9]/i
  IPv6_ADDRESSES = %r/((#{HEXDIGIT}+:){5}#{HEXDIGIT}+)/
  EQUATE = %r/\s*(?:=>|[:=]|,)\s*/
  USER_EQUALS = %r/(user#{EQUATE})\S+/i
  PASSWORD_EQUALS = %r/(passw?(or)?d?#{EQUATE})\S+/i
  UN = %r[\b(?:[ul]\/?n?)\b]i
  PW = %r[\b(?:p\/?w?)\b]i
  USERNAME_AND_PASSWORD = %r/(#{UN}#{EQUATE})\S+(\s*#{PW}#{EQUATE})\S+/
  GITHUB_URL = %r[((?:git@|(?:https?|git)://)github.com/)[^/]+/.+(\.git)?]i
  GIT_URL = %r[(ssh|git|https?|ftp|rsync)://\S+(\.git)]
  SSH_URL = %r[(ssh://)\S+]i
  CAPISTRANO_KEYWORDS = %r/((?:host_name|port|deploy_to|application)(?:#{EQUATE}))\S+/
  CAPISTRANO_SERVER = %r/(\bserver\s+)\S+,/

  def self.wipe input
    cleanups = username_cleanups + [
      hostname_cleanup,
      [ IPv4_ADDRESSES, -> { check_address $1 } ],
      [ IPv6_ADDRESSES, -> { 'aa:bb:cc:dd:ee:ff' } ],
      [ USER_EQUALS, -> { "#$1hiddenuser" } ],
      [ PASSWORD_EQUALS, -> { "#$1hiddenpass" } ],
      [ USERNAME_AND_PASSWORD, -> { "#$1hiddenuser#$2hiddenpass" } ],
      [ GITHUB_URL, -> { "#$1hiddenrepo#$2" } ],
      [ GIT_URL, -> { "#$1://hiddenrepo" } ],
      [ SSH_URL, -> { "#$1hiddensshurl" } ],
      [ CAPISTRANO_KEYWORDS, -> { "#$1caphidden" } ],
      [ CAPISTRANO_SERVER, -> { "#$1capserver" } ],
    ]
    cleanups.inject input do |result, xform|
      result.gsub xform[0] do xform[1].call end
    end
  end

  def self.username_cleanups
    users = read_etc_passwd.split(/\n/).map do |e|
      username, archaic, uid, *junk = e.split ':'
      uid.to_i >= 1000 and username
    end.compact
    users.map do |e|
      [ %r/\b#{e}\b/, -> { 'hiddenuser' } ]
    end
  end
  def self.read_etc_passwd; File.read '/etc/passwd' end

  def self.hostname_cleanup
    [ %r/\b#{find_hostname}\b/, -> { 'hiddenhost' } ]
  end
  def self.find_hostname; `hostname`.chomp || 'weird, no hostname' end

  PASSTHRU_ADDRESSES = %w(127.0.0.1 0.0.0.0)
  def self.check_address addr
    if PASSTHRU_ADDRESSES.include? addr
      addr
    else
      'XX.YY.ZZ.AA'
    end
  end
end

