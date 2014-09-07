FactoryGirl.define do
  factory :default_reservation, :class => "Reservation" do
    table_id 10
    start_time DateTime.new(2001, 2, 3, 13)
    end_time DateTime.new(2001, 2, 3, 16)
  end

  factory :valid_reservation, :class => "Reservation" do
    table_id 10
    start_time DateTime.new(2001, 2, 3, 6)
    end_time DateTime.new(2001, 2, 3, 8)
  end

  factory :update_reservation, :class => "Reservation" do
    table_id 10
    start_time DateTime.new(2001, 2, 3, 1)
    end_time DateTime.new(2001, 2, 3, 2)
  end

  factory :crossing_reservation, :class => "Reservation" do
    table_id 10
    start_time DateTime.new(2001, 2, 3, 12)
    end_time DateTime.new(2001, 2, 3, 14)
  end

  factory :inner_reservation, :class => "Reservation" do
    table_id 10
    start_time DateTime.new(2001, 2, 3, 14)
    end_time DateTime.new(2001, 2, 3, 15)
  end

  factory :outer_reservation, :class => "Reservation" do
    table_id 10
    start_time DateTime.new(2001, 2, 3, 12)
    end_time DateTime.new(2001, 2, 3, 17)
  end
end
