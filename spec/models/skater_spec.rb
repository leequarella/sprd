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
end
