module WrapActiveadmin

  module NonDbModel

    extend ActiveSupport::Concern

    included do
      include ActiveModel::Model

      def initialize(attributes = {})
        self.attributes = attributes
      end

      def persisted?
        false
      end

      def new_record?
        true
      end

      def create
        return false unless valid?
      end

      def self.create(attributes = {})
        object = new(attributes)
        object.create
      end

      alias_method :save, :create

      private

      def attributes=(attributes)
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
    end

  end

end
