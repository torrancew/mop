class Sist
  def self.sanitize input
    result = input.dup
    result.gsub! /(passw?(or)?d?\s?[=:]\s?)\S+/i do
      "#$1hiddenpass"
    end
    result.gsub! /((?:[ul]\/?n?)[:=])\s?\S+\s?((?:p\/?w?)[:=])\s?\S+/i do
      "#$1hiddenuser #$2hiddenpass"
    end
    result
  end
end
