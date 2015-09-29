module Locomotive
  class Message

    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :first_name, :last_name, :phone, :brokerage, :email, :additional_notes

    validates :first_name,
      presence: true
    validates :last_name,
      presence: true

    validates :email,
      presence: true

    validates :phone,
      presence: true

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      false
    end
  end

end