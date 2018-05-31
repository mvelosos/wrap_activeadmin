module CbStem

  module ReferenceKeyGenerator

    extend ActiveSupport::Concern

    class_methods do
      def assign_reference_key(key, *args)
        after_create -> { generate_reference_key(key, *args) }
      end
    end

    private

    def generate_reference_key(key, *args)
      loop do
        random_code = build_code(*args)
        send("#{key}=", random_code)
        break unless self.class.exists?(["#{key} =?", random_code])
      end
      save(validate: false)
    end

    def build_code(pattern: default_pattern, length: 4, prefix: nil, suffix: nil)
      pattern = pattern.map(&:to_a).flatten
      code    = (0..(length - 1)).map { pattern[rand(pattern.length)] }.join
      prefix  = prefix.is_a?(Proc) ? prefix.call(self) : prefix
      suffix  = suffix.is_a?(Proc) ? suffix.call(self) : suffix
      "#{prefix}#{code}#{suffix}"
    end

    def default_pattern
      [('a'..'z')]
    end

  end

end
