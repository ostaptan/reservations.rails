class Reservation < ActiveRecord::Base
  validates_presence_of :table_id, :start_time, :end_time
  validate :validate_params

  scope :validate_time_and_id, ->(obj) do 
    where(["table_id = ? AND id <> ? AND (start_time < ? AND end_time > ?)", obj.table_id, obj.id, obj.end_time, obj.start_time]) 
  end

  scope :validate_time, ->(obj) do
    where(["table_id = ? AND (start_time < ? AND end_time > ?)", obj.table_id, obj.end_time, obj.start_time])
  end

  before_create :validate_time
  before_update { validate_time(with_id = true) }

  private

  def validate_time(with_id = false)
    condition = with_id ? self.class.validate_time_and_id(self).empty? : self.class.validate_time(self).empty?
    errors[:base] << "Table is already booked at this time" unless condition
    errors.empty?
  end

  def validate_params
    errors.add(:table_id, 'must be a valid integer') unless table_id.is_a? Integer
    errors.add(:start_time, 'must be a valid datetime') unless start_time.is_a? Time
    errors.add(:end_time, 'must be a valid datetime') unless end_time.is_a? Time
  end

end
