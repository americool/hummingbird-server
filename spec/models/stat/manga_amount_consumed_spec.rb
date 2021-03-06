require 'rails_helper'

RSpec.describe Stat::MangaAmountConsumed do
  # will create some library entries for me
  let(:user) { create(:user) }
  let(:manga) { create(:manga) }
  let(:manga1) { create(:manga) }
  let!(:le) do
    create(
      :library_entry, user: user, manga: manga, progress: 10, time_spent: 0
    )
  end
  let!(:le1) do
    create(
      :library_entry, user: user, manga: manga1, progress: 5, time_spent: 0
    )
  end

  before(:each) do
    subject = Stat.find_by(user: user, type: 'Stat::MangaAmountConsumed')
    subject.recalculate!
  end

  describe '#recalculate!' do
    it 'should add all library entries related to user' do
      record = Stat.find_by(user: user, type: 'Stat::MangaAmountConsumed')

      expect(record.stats_data['all_time']['total_media']).to eq(2)
      expect(record.stats_data['all_time']['total_progress']).to eq(15)
      expect(record.stats_data['all_time']['total_time']).to eq(0)
    end
  end

  describe '#increment' do
    it 'should update all stats_data' do
      record = Stat.find_by(user: user, type: 'Stat::MangaAmountConsumed')

      expect(record.stats_data['all_time']['total_media']).to eq(2)
      expect(record.stats_data['all_time']['total_progress']).to eq(15)
      expect(record.stats_data['all_time']['total_time']).to eq(0)
    end
  end

  describe '#decrement' do
    before do
      Stat::MangaAmountConsumed.decrement(user, le)
    end
    it 'should remove le from stats_data' do
      record = Stat.find_by(user: user, type: 'Stat::MangaAmountConsumed')

      expect(record.stats_data['all_time']['total_media']).to eq(1)
      expect(record.stats_data['all_time']['total_progress']).to eq(5)
      expect(record.stats_data['all_time']['total_time']).to eq(0)
    end
  end
end
