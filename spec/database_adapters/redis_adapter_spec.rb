require 'spec_helper'

describe RedisAdapter do
  let(:toggle_name) { 'my_toggle' }
  let(:redis_database) { double }
  subject { RedisAdapter.new(redis_database) }

  describe '#add_toggle' do
    before { allow(redis_database).to receive(:set) { 'OK' } }

    it 'adds the toggle to database' do
      expect(redis_database).to receive(:set).with(toggle_name, 't') { 'OK' }
      subject.add_toggle(toggle_name)
    end

    it 'returns true' do
      expect(subject.add_toggle(toggle_name)).to eq(true)
    end
  end

  describe '#remove_toggle' do
    before { allow(redis_database).to receive(:del) { 1 } }

    it 'adds the toggle to database' do
      expect(redis_database).to receive(:del).with(toggle_name) { 1 }
      subject.remove_toggle(toggle_name)
    end

    it 'returns true' do
      expect(subject.remove_toggle(toggle_name)).to eq(true)
    end
  end

  describe '#exists?' do
    context 'when the toggle is defined' do
      before { allow(redis_database).to receive(:get) { 't' } }

      it 'returns true' do
        expect(subject.exists?(toggle_name)).to eq(true)
      end
    end

    context 'when the toggle is not defined' do
      before { allow(redis_database).to receive(:get) { nil } }

      it 'returns false' do
        expect(subject.exists?(toggle_name)).to eq(false)
      end
    end
  end
end
