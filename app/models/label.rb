class Label < ActiveRecord::Base
  validates :url, :tracking_code, :parcel_id, :from_id, :to_id, presence: true

  def date
    self.created_at.to_time.strftime("%b %d, %Y %I:%M %p") 
  end




end
