require 'rails_helper'

describe Reservation, type: :model do
  before do
    create(:default_reservation)
  end

  #success way
  it "creates reservarion successfully" do
    expect(create(:valid_reservation)).to be_truthy
  end

  it "updates reservation successfully" do
    expect(create(:update_reservation).update(attributes_for(:valid_reservation))).to be_truthy
  end

  #failing way
  context "#create reservation" do
    it "fails to create reservation when it has crossing hours interval" do
      expect(build(:crossing_reservation).save).to be_falsy
    end

    it "fails to create reservation when it has inner hours interval" do
      expect(build(:inner_reservation).save).to be_falsy
    end

    it "fails to create reservation when it has outer hours interval" do
      expect(build(:outer_reservation).save).to be_falsy
    end

  end

  context "#update reservation" do
    it "fails to update reservation when it has crossing hours interval" do
      update_params = attributes_for(:crossing_reservation)
      expect(create(:update_reservation).update(update_params)).to be_falsy
    end

    it "fails to update reservation when it has inner hours interval" do
      update_params = attributes_for(:inner_reservation)
      expect(create(:update_reservation).update(update_params)).to be_falsy
    end

    it "fails to update reservation when it has outer hours interval" do
      update_params = attributes_for(:outer_reservation)
      expect(create(:update_reservation).update(update_params)).to be_falsy
    end

  end
end