require 'rails_helper'

RSpec.describe Skater, :type => :model do
  describe "attended?" do
    let(:skater) { Skater.create }
    let(:practice) {Practice.create}
    context "skater was at practice as 'attended'" do
      let!(:skater_practice) {SkaterPractice.create(skater: skater, practice:practice,
                                                   status: "attended")}
      it "returns true" do
        expect(skater.attended? practice).to be true
      end
    end
    context "skater was at practice as 'absent'" do
      let!(:skater_practice) {SkaterPractice.create(skater: skater, practice:practice,
                                                   status: "absent")}
      it "returns false" do
        expect(skater.attended? practice).to be false
      end
    end
    context "there is no record for this skater at practice" do
      it "returns false" do
        SkaterPractice.destroy_all
        expect(skater.attended? practice).to be false
      end
    end
  end

  describe "status_for" do
    let(:skater) { Skater.create }
    let(:practice) {Practice.create}
    context "a record exists for this skater at this practice" do
      let!(:skater_practice) {SkaterPractice.create(skater: skater, practice:practice,
                                                   status: "attended")}
      it "returns the status" do
        expect(skater.status_for practice).to eq 'attended'
      end
    end
    context "no record exists for this skater at this practice" do
      it "returns 'absent'" do
        SkaterPractice.destroy_all
        expect(skater.status_for practice).to eq 'absent'
      end
    end
  end

  describe "roster_eligible?" do
    let!(:skater) { Skater.create }
    let!(:wed_practice_1) {Practice.create(date: DateTime.new(2014, 6, 4))}
    let!(:wed_practice_2) {Practice.create(date: DateTime.new(2014, 6, 12))}
    let!(:sun_practice_1) {Practice.create(date: DateTime.new(2014, 6, 7))}
    let!(:sun_practice_2) {Practice.create(date: DateTime.new(2014, 6, 15))}
    context "skater has made all wednesday practices and 50% of sunday practices" do
      let!(:skater_practice_1) {SkaterPractice.create(skater: skater, practice: wed_practice_1,
                                                   status: "attended")}
      let!(:skater_practice_2) {SkaterPractice.create(skater: skater, practice: wed_practice_2,
                                                   status: "attended")}
      let!(:skater_practice_3) {SkaterPractice.create(skater: skater, practice:sun_practice_2,
                                                   status: "attended")}
      it "returns true" do
        expect(skater.roster_eligible?(from: Date.new(2014, 6, 1), to: Date.new(2014, 7, 1)))
          .to be true
      end
    end
    context "skater has missed a wednesday practice" do
      let!(:skater_practice) {SkaterPractice.create(skater: skater, practice:wed_practice_1,
                                                   status: "absent")}
      it "returns false" do
        expect(skater.roster_eligible?(from: Date.new(2014, 6, 1), to: Date.new(2014, 7, 1)))
          .to be false
      end
    end
    context "skater has missed a more than 50% of sundays" do
      let!(:skater_practice_1) {SkaterPractice.create(skater: skater, practice: wed_practice_1,
                                                   status: "attended")}
      let!(:skater_practice_2) {SkaterPractice.create(skater: skater, practice: wed_practice_2,
                                                   status: "attended")}
      it "returns false" do
        expect(skater.roster_eligible?(from: Date.new(2014, 6, 1), to: Date.new(2014, 7, 1)))
          .to be false
      end
    end
  end
end
