class Mop
  PASSTHRU_ADDRESSES = %w(127.0.0.1 0.0.0.0)
  def self.wipe input
    result = input.dup
    [
      [ %r/(passw?(or)?d?\s*[=:]\s*)\S+/i, -> { "#$1hiddenpass" } ],
      [
        %r/((?:[ul]\/?n?)[:=])\s*\S+\s*((?:p\/?w?)[:=])\s*\S+/i, -> {
          "#$1hiddenuser #$2hiddenpass"
        }
      ],
      [
        %r/((\d+\.){3}\d+)/, -> {
          if PASSTHRU_ADDRESSES.include? $1; $1 else 'hiddenaddress' end
        }
      ],
    ].each do |xform|
        result.gsub! xform[0] do xform[1].call end
    end
    result
  end
end
