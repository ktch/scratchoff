module RedemptionHelper

  def is_redeemed?
    cookies[:redeemed] = { :value => true, :expires => 10.days.from_now }
  end

end