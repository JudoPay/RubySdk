require_relative '../model'
require_relative 'payment'
require_relative 'card_address'

module Judopay
  class GetOneTimeToken < Model
    @resource_path = 'encryptions/paymentDetails'
    @valid_api_methods = [:create]

    attribute :judo_id, String
    attribute :card_number, String
    attribute :expiry_date, String
    attribute :cv2, String

    validates_presence_of :judo_id,
                          :card_number,
                          :expiry_date,
                          :cv2
  end
end
