class Sist
  def self.sanitize input
    input.gsub! /(passw?(or)?d?\s?[=:]\s?)\S+/i do
      "#$1 hiddenpass"
    end
    input.gsub! /((?:[ul]\/?n?)[:=])\s?\S+\s?((?:p\/?w?)[:=])\s?\S+/i do
      "#$1 hiddenuser #$2 hiddenpass"
    end
    input
  end
end
