class Mop
  ADDRESSES = %r/((\d+\.){3}\d+)/
  EQUATE = %r/\s*[:=]?>?,?\s*/
  PASSWD = %r/passw?(or)?d?/i
  PASSWORD_EQUALS = %r/(#{PASSWD}#{EQUATE})\S+/
  UN = %r[\b(?:[ul]\/?n?)\b]i
  PW = %r[\b(?:p\/?w?)\b]i
  USERNAME_AND_PASSWORD = %r/(#{UN}#{EQUATE})\S+(\s*#{PW}#{EQUATE})\S+/
  CAPISTRANO_KEYWORDS = %r/(?:host_name|port|deploy_to)(?:#{EQUATE})?/
  CAPISTRANO_SERVER = %r/(?:\bserver\s+)/
  CAPISTRANO = %r/(#{CAPISTRANO_KEYWORDS}|#{CAPISTRANO_SERVER})\S+/

  def self.wipe input
    [
      [ ADDRESSES, -> { check_address $1 } ],
      [ PASSWORD_EQUALS, -> { "#$1hiddenpass" } ],
      [ USERNAME_AND_PASSWORD, -> { "#$1hiddenuser#$2hiddenpass" } ],
      [ CAPISTRANO, -> { "#$1caphidden" } ],
    ].inject input do |result, xform|
      result.gsub xform[0] do xform[1].call end
    end
  end

  PASSTHRU_ADDRESSES = %w(127.0.0.1 0.0.0.0)
  def self.check_address addr
    if PASSTHRU_ADDRESSES.include? addr
      addr
    else
      'hiddenaddress'
    end
  end
end

