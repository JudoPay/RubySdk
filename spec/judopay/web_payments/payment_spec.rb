require 'spec_helper'
require_relative '../../../lib/judopay/models/web_payments/payment'

describe Judopay::WebPayments::Payment do
  it "should give details of a single web payment given a valid reference" do
    reference = '4gcBAAMAGAASAAAADA66kRor6ofknGqU3A6i-759FprFGPH3ecVcW5ChMQK0f3pLBQ'
    stub_get('/webpayments/' + reference).
      to_return(:status => 200,
                :body => lambda { |request| fixture("web_payments/payments/find.json") })

    payment = Judopay::WebPayments::Payment.find(reference)
    expect(payment).to be_a(Hash)
    expect(payment.reference).to eq(reference)                   
  end
end