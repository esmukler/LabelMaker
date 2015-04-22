require 'easypost'

class LabelsController < ApplicationController

  def new
    @label = Label.new
    render :new
  end

  def create
    EasyPost.api_key = 'nGBFBESOvSJiIvrxs376HA'


    begin
      shipment = EasyPost::Shipment.create({
        to_address: params[:to_address],
        from_address: params[:from_address],
        parcel: params[:parcel]
      })
    rescue EasyPost::Error => e

      flash[:errors] = e.message[19..-1]

      redirect_to new_label_url and return
    end

    begin
      shipment.buy(rate: shipment.lowest_rate)
    rescue EasyPost::Error => e

      flash[:errors] = "No rates found. Check that both addresses are correct."
      redirect_to new_label_url and return
    end

    url = shipment.postage_label.label_url

    @label = Label.new(
      url: url,
      tracking_code: shipment.tracking_code,
      parcel_id: shipment.parcel.id,
      to_id: shipment.to_address.id,
      from_id: shipment.from_address.id
    )

    if @label.save
      redirect_to label_url(@label)
    else
      flash[:errors] = @label.errors.full_messages
      render :new
    end

  end

  def show
    @label = Label.find(params[:id])
    render :show
  end

  def index
    @labels = Label.all.order(created_at: :desc)
    render :index
  end


end
