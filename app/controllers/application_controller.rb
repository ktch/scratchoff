class ApplicationController < ActionController::Base
  protect_from_forgery
  include CookieDetection
  include SessionsHelper
  include RedemptionHelper
end
