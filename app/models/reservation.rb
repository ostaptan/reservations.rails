class Reservation < ActiveRecord::Base
  validates_presence_of :table_id, :start_time, :end_time
  validate :valid_datetime_fields

  before_create :validate_time
  before_update :validate_time_with_id

  private

  def validate_time
    unless self.class.where(["table_id = ? AND (start_time < ? AND end_time > ?)", table_id, end_time, start_time]).empty?
      errors[:base] << "Table is already booked at this time"
    end
    errors.empty?
  end

  def validate_time_with_id
    unless self.class.where(["table_id = ? AND id <> ? AND (start_time < ? AND end_time > ?)", table_id, id, end_time, start_time]).empty?
      errors[:base] << "Table is already booked at this time"
    end
    errors.empty?
  end

  def valid_datetime_fields
    errors.add(:start_time, 'must be a valid datetime') if ((DateTime.parse(start_time.to_s) rescue ArgumentError) == ArgumentError)
    errors.add(:end_time, 'must be a valid datetime') if ((DateTime.parse(end_time.to_s) rescue ArgumentError) == ArgumentError)
  end

end
