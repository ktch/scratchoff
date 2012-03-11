class PrizesController < ApplicationController
  include PrizesHelper
  
  # before_filter :is_campaign?
  before_filter :authenticate
  # before_filter :correct_admin, :only => [:edit, :update]
  # GET /prizes
  # GET /prizes.json
  # GET /prizes/1/edit
  
  def new
    @prize = Prize.new if signed_in?
  end
  
  def edit
    @prize = Prize.find(params[:id])
  end
  
  def show
    @prize = Prize.find(params[:id])
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @prize = current_admin.prizes.build(params[:prize])
    if @prize.save
      redirect_to @prize, :flash => { :success => "Prize created" }
    else
      render 'sessions/new'
    end
  end

  # PUT /prizes/1
  # PUT /prizes/1.json
  def update
    @prize = Prize.find(params[:id])
    if @prize.update_attributes(params[:prize])
      redirect_to @prize, :flash => { :success => "Prize updated" }
    else
      @title = "Update Prize"
      render 'edit'
    end
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.json
  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy

  end
  
end
