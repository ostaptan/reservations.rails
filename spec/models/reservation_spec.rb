require 'rails_helper'

describe Reservation do
  before do
    Reservation.create({table_id: 10, start_time: DateTime.new(2001, 2, 3, 13), end_time: DateTime.new(2001, 2, 3, 16)})
  end

  let(:valid_params) do
    { table_id: 10, start_time: DateTime.new(2001, 2, 3, 6), end_time: DateTime.new(2001, 2, 3, 8) }
  end

  #success way
  it "creates and updates reservation successfully" do
    expect(Reservation.new(valid_params).save).to be_truthy
    update_record = Reservation.create({start_time: DateTime.new(2001, 3, 3, 1), end_time: DateTime.new(2001, 3, 3, 2)})
    expect(update_record.update(valid_params)).to be_truthy
  end

  #failing way
  context "#create reservation" do
    it "fails to create reservation when it has crossing hours interval" do
      create_params = { table_id: 10, start_time: DateTime.new(2001, 2, 3, 12), end_time: DateTime.new(2001, 2, 3, 14) }
      expect(Reservation.new(create_params).save).to be_falsy
    end

    it "fails to create reservation when it has inner hours interval" do
      create_params = { table_id: 10, start_time: DateTime.new(2001, 2, 3, 14), end_time: DateTime.new(2001, 2, 3, 15) }
      expect(Reservation.new(create_params).save).to be_falsy
    end

    it "fails to create reservation when it has outer hours interval" do
      create_params = { table_id: 10, start_time: DateTime.new(2001, 2, 3, 12), end_time: DateTime.new(2001, 2, 3, 17) }
      expect(Reservation.new(create_params).save).to be_falsy
    end

  end

  context "#update reservation" do
    it "fails to update reservation when it has crossing hours interval" do
      update_params = { start_time: DateTime.new(2001, 2, 3, 12), end_time: DateTime.new(2001, 2, 3, 14) }
      update_record = Reservation.create({table_id: 10, start_time: DateTime.new(2001, 3, 3, 18), end_time: DateTime.new(2001, 3, 3, 20)})
      expect(update_record.update(update_params)).to be_falsy
    end

    it "fails to update reservation when it has inner hours interval" do
      update_params = { start_time: DateTime.new(2001, 2, 3, 14), end_time: DateTime.new(2001, 2, 3, 15) }
      update_record = Reservation.create({table_id: 10, start_time: DateTime.new(2001, 3, 3, 18), end_time: DateTime.new(2001, 3, 3, 20)})
      expect(update_record.update(update_params)).to be_falsy
    end

    it "fails to update reservation when it has outer hours interval" do
      update_params = { start_time: DateTime.new(2001, 2, 3, 12), end_time: DateTime.new(2001, 2, 3, 17) }
      update_record = Reservation.create({table_id: 10, start_time: DateTime.new(2001, 3, 3, 18), end_time: DateTime.new(2001, 3, 3, 20)})
      expect(update_record.update(update_params)).to be_falsy
    end

  end


#   it "fails to create/update reservation of booked table" do
#     p = { table_id: 10, start_date: DateTime.new(2001, 2, 3, 1), end_date: DateTime.new(2001, 2, 3, 3) }
#     update_record = App::Models::Reservation.create({table_id: 10, start_date: DateTime.new(2001, 2, 3, 4), end_date: DateTime.new(2001, 2, 3, 5)})
#     expect(App::Models::Reservation.new.safe_create(p).first).to eq 500
#     expect(update_record.safe_update(p).first).to eq 500
#     p = { table_id: 10, start_date: DateTime.new(2001, 2, 3, 3), end_date: DateTime.new(2001, 2, 3, 3, 40) }
#     expect(App::Models::Reservation.new.safe_create(p).first).to eq 500
#     expect(update_record.safe_update(p).first).to eq 500
#     p = { table_id: 10, start_date: DateTime.new(2001, 2, 3, 3), end_date: DateTime.new(2001, 2, 3, 6) }
#     expect(App::Models::Reservation.new.safe_create(p).first).to eq 500
#     expect(update_record.safe_update(p).first).to eq 500
#   end
end