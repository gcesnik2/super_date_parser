require 'rails_helper'

RSpec.describe DateService, type: :model do
  describe '#string_to_dates' do
    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("May 18").string_to_dates

      expect(start_date).to eq('May 18')
      expect(end_date).to eq('May 18')
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Sat, May 18").string_to_dates
      
      expect(start_date).to eq('Sat May 18')
      expect(end_date).to eq('Sat May 18')
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Sat, May 18, 6 – 10 PM CDT").string_to_dates

      expect(start_date).to eq('Sat May 18 6 PM')
      expect(end_date).to eq('Sat May 18 10 PM')
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Wed, May 15 – Thu, May 16").string_to_dates

      expect(start_date).to eq('Wed May 15')
      expect(end_date).to eq('Thu May 16')
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Fri, May 17, 9 PM – Sat, May 18, 1 AM CDT").string_to_dates

      expect(start_date).to eq('Fri May 17 9 PM')
      expect(end_date).to eq('Sat May 18 1 AM')
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Sat, May 18, 9 PM – Sun, May 19, 12 AM").string_to_dates

      expect(start_date).to eq('Sat May 18 9 PM')
      expect(end_date).to eq('Sun May 19 12 AM')
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Sat, May 18, 9 PM CDT").string_to_dates

      expect(start_date).to eq('Sat May 18 9 PM')
      expect(end_date).to eq(nil)
    end

    it 'will convert datetime range string to datetimes' do

      start_date, end_date = DateService.new("Sat, May 18, 9 PM").string_to_dates

      expect(start_date).to eq('Sat May 18 9 PM')
      expect(end_date).to eq(nil)
    end
  end
end

