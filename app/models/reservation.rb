class Reservation < ActiveRecord::Base
  validates_presence_of :table_id, :start_time, :end_time
  validate :valid_time_fields

  before_create do
    validate_time
  end

  before_update do
    validate_time(with_id = true)
  end

  private

  def validate_time(with_id = false)
    condition = if with_id
                  self.class.where(["table_id = ? AND id <> ? AND (start_time < ? AND end_time > ?)", table_id, id, end_time, start_time]).empty?
                else
                  self.class.where(["table_id = ? AND (start_time < ? AND end_time > ?)", table_id, end_time, start_time]).empty?
                end
    errors[:base] << "Table is already booked at this time" unless condition
    errors.empty?
  end

  def valid_time_fields
    errors.add(:start_time, 'must be a valid datetime') unless start_time.is_a? Time
    errors.add(:end_time, 'must be a valid datetime') unless end_time.is_a? Time
  end

end
