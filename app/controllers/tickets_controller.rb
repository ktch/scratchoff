class TicketsController < ApplicationController
  def generate
    @title = "BPampm Scratchoff"
    cookies[:redeemed] = "not_redeemed"
  end
end