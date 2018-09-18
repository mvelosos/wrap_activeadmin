module WrapActiveadmin

  module Generators

    # Helper Method For Generators
    module Helper

      def remove_file(path)
        return unless file_exist?(path)
        File.delete(Rails.root + path)
      end

      def file_exist?(path)
        File.exist?(Rails.root + path)
      end

    end

  end

end
