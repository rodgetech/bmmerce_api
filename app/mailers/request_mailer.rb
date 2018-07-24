class RequestMailer < ApplicationMailer
  require 'mailgun'

  def rent_request(request)
    @request = request
    mail to: "luisrodge@outlook.com"
  end
end
