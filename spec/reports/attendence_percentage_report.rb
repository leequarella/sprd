require 'rails_helper'

describe AttendencePercentageReport do
  let(:skater_1){Skater.create}
  let(:skater_2){Skater.create}
  let(:practice_1){Practice.create(date: Time.now)}
  let(:practice_2){Practice.create(date: 1.week.ago)}
  let!(:skater_1_practice_1){SkaterPractice.create(practice: practice_1, skater: skater_1)}
  let!(:skater_1_practice_2){SkaterPractice.create(practice: practice_2, skater: skater_1)}
  let!(:skater_2_practice_2){SkaterPractice.create(practice: practice_2, skater: skater_2)}
  it 'initializes with a date range' do
    report = AttendencePercentageReport.new(start_date: 1.day.ago, end_date: 1.day.from_now)
    expect(report.skaters).to eq Skater.all
  end

  it "finds the correct practices" do
    report = AttendencePercentageReport.new(start_date: 1.day.ago, end_date: 1.day.from_now)
    expect(report.practices.first).to eq practice_1
    expect(report.practices.length).to eq 1
    report = AttendencePercentageReport.new(start_date: 1.month.ago, end_date: 1.day.from_now)
    expect(report.practices.first).to eq practice_1
    expect(report.practices.last).to eq practice_2
    expect(report.practices.length).to eq 2
  end

  it 'calculates attendence percentage for each skater in the given date range' do
    report = AttendencePercentageReport.new(start_date: 1.month.ago, end_date: 1.day.from_now)
    expect(report.skaters.first).to eq skater_1
    expect(report.skaters.first.attendence_percentage).to eq 100
    expect(report.skaters.last).to eq skater_2
    expect(report.skaters.last.attendence_percentage).to eq 50
  end
end
