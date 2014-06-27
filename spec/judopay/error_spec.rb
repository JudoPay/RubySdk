require 'spec_helper'
require_relative '../../lib/judopay/error'

describe Judopay::Error do
  it "returns a 'message' equal to the class name if the message is not set, because 'message' should not be nil" do
    e = Judopay::Error.new
    expect(e.message).to eq('Judopay::Error')
  end

  it "returns the 'message' that was set" do
    e = Judopay::Error.new
    message = "An explicitly set message"
    e.message = message
    expect(e.message).to eq(message)
  end

  it "contains exceptions in Judopay" do
    expect(Judopay::BadRequest.new).to be_a_kind_of(Judopay::Error)
  end

  it "makes error information available on the exception object for API errors" do
    stub_post('/transactions/payments').
      to_return(:status => 400,
                :body => lambda { |request| fixture("card_payments/create_bad_request.json") },
                :headers => { 'Content-Type' => 'application/json' })

    payment = build(:card_payment)
    
    begin
      response = payment.create
    rescue Judopay::BadRequest => e
      expect(e.http_status).to eq(400)
      expect(e.model_errors).to be_a_kind_of(Array)
      expect(e.error_type).to eq(9)
      expect(e.message).to eq('Please check the card token.') 
    end
  end

  it "makes error information available on the exception object for validation errors" do

    payment = Judopay::CardPayment.new
    
    begin
      response = payment.create
    rescue Judopay::ValidationError => e
      expect(e.model_errors).to be_a_kind_of(Array)
      expect(e.message).to eq('Missing required fields') 
    end
  end  
end