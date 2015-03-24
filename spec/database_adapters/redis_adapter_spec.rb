require 'spec_helper'

describe RedisAdapter do
  let(:toggle_name) { 'my_toggle' }
  let(:redis_database) { double }
  subject { RedisAdapter.new(redis_database) }

  describe '#add_toggle' do
    before { allow(redis_database).to receive(:hset) { 'OK' } }

    it 'adds the toggle to database' do
      expect(redis_database).to receive(:hset).with('chirrin-chirrion-toggles', toggle_name, 'i') { 1 }
      subject.add_toggle(toggle_name)
    end

    it 'adds the active toggle to database' do
      expect(redis_database).to receive(:hset).with('chirrin-chirrion-toggles', toggle_name, 'a') { 0 }
      subject.add_toggle(toggle_name, 'a')
    end

    it 'returns true' do
      expect(subject.add_toggle(toggle_name)).to eq(true)
    end
  end

  describe '#remove_toggle' do
    before { allow(redis_database).to receive(:hdel) { 1 } }

    it 'adds the toggle to database' do
      expect(redis_database).to receive(:hdel).with('chirrin-chirrion-toggles', toggle_name) { 1 }
      subject.remove_toggle(toggle_name)
    end

    it 'returns true' do
      expect(subject.remove_toggle(toggle_name)).to eq(true)
    end
  end

  describe '#activate' do
    it 'makes a toggle active' do
      expect(subject).to receive(:add_toggle).with(toggle_name, 'a') { true }
      subject.activate(toggle_name)
    end
  end

  describe '#inactivate' do
    it 'makes a toggle active' do
      expect(subject).to receive(:add_toggle).with(toggle_name, 'i') { true }
      subject.inactivate(toggle_name)
    end
  end

  describe '#active?' do
    context 'when the toggle is active' do
      before { allow(redis_database).to receive(:hget) { 'a' } }

      it 'search the toggle on database' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { 'a' }
        subject.active?(toggle_name)
      end

      it 'returns true' do
        expect(subject.active?(toggle_name)).to eq(true)
      end
    end

    context 'when the toggle is inactive' do
      before { allow(redis_database).to receive(:hget) { 'i' } }

      it 'search the toggle on database' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { 'i' }
        subject.active?(toggle_name)
      end

      it 'returns false' do
        expect(subject.active?(toggle_name)).to eq(false)
      end
    end

    context 'when the toggle is not defined' do
      before { allow(redis_database).to receive(:hget) { nil } }

      it 'search the toggle on database' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { nil }
        subject.active?(toggle_name)
      end

      it 'returns false' do
        expect(subject.active?(toggle_name)).to eq(false)
      end
    end
  end

  describe '#inactive?' do
    context 'when #active? returns true' do
      before { allow(subject).to receive(:active?) { true } }

      it 'verifies if toggle is active' do
        expect(subject).to receive(:active?).with(toggle_name) { true }
        subject.inactive?(toggle_name)
      end

      it 'returns false' do
        expect(subject.inactive?(toggle_name)).to eq(false)
      end
    end

    context 'when #active? returns false' do
      before { allow(subject).to receive(:active?) { false } }

      it 'verifies if toggle is active' do
        expect(subject).to receive(:active?).with(toggle_name) { false }
        subject.inactive?(toggle_name)
      end

      it 'returns true' do
        expect(subject.inactive?(toggle_name)).to eq(true)
      end
    end
  end
end
