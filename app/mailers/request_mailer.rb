class RequestMailer < ApplicationMailer
  require 'mailgun'

  def rent_request(user = nil, request)
    @request = request
    mail to: "luisrodge@outlook.com"
  end
end
