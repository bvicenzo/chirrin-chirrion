require 'spec_helper'

describe ChirrinChirrion::DatabaseAdapters::RedisAdapter do
  let(:toggle_name) { 'my_toggle' }
  let(:redis_database) { double }
  subject { ChirrinChirrion::DatabaseAdapters::RedisAdapter.new(redis_database) }

  describe '#add_toggle' do
    before { allow(redis_database).to receive(:hset) { 'OK' } }

    it 'adds the toggle to database' do
      toggle_info = {description: 'This toggle active de Feature X which allow us to do this'}
      expect(redis_database).to receive(:hset).with('chirrin-chirrion-toggles', toggle_name, {description: 'This toggle active de Feature X which allow us to do this', active: false}.to_json) { 1 }
      subject.add_toggle(toggle_name, toggle_info)
    end

    it 'adds the active toggle to database' do
      toggle_info = {active: true, description: 'This toggle active de Feature Y which allow us to do that'}
      expect(redis_database).to receive(:hset).with('chirrin-chirrion-toggles', toggle_name, {active: true, description: 'This toggle active de Feature Y which allow us to do that'}.to_json) { 1 }
      subject.add_toggle(toggle_name, toggle_info)
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

  describe '#activate!' do
    context 'when there is no toggle' do
      it 'raises toggle not found error' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { nil }
        expect{subject.activate!(toggle_name)}.to raise_error(ChirrinChirrion::Errors::ToggleNotFound, "The toggle #{toggle_name} was not found")
      end
    end

    context 'when there is toggle' do
      it 'makes a toggle active' do
        toggle_info           = {active: false, description: 'This toggle active de Feature Y which allow us to do that'}
        activated_toggle_info = {active: true, description: 'This toggle active de Feature Y which allow us to do that'}
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { toggle_info.to_json }
        expect(redis_database).to receive(:hset).with('chirrin-chirrion-toggles', toggle_name, activated_toggle_info.to_json) { 1 }
        subject.activate!(toggle_name)
      end
    end
  end

  describe '#inactivate!' do
    context 'when there is no toggle' do
      it 'raises toggle not found error' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { nil }
        expect{subject.inactivate!(toggle_name)}.to raise_error(ChirrinChirrion::Errors::ToggleNotFound, "The toggle #{toggle_name} was not found")
      end
    end

    context 'when there is toggle' do
      it 'makes a toggle inactive' do
        toggle_info             = { active: true, description: 'This toggle active de Feature Y which allow us to do that'}
        inactivated_toggle_info = { active: false, description: 'This toggle active de Feature Y which allow us to do that'}
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { toggle_info.to_json }
        expect(redis_database).to receive(:hset).with('chirrin-chirrion-toggles', toggle_name, inactivated_toggle_info.to_json) { 1 }
        subject.inactivate!(toggle_name)
      end
    end
  end

  describe '#active?' do
    context 'when the toggle is active' do
      before { allow(redis_database).to receive(:hget) { {active: true}.to_json } }

      it 'search the toggle on database' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { {active: true}.to_json }
        subject.active?(toggle_name)
      end

      it 'returns true' do
        expect(subject.active?(toggle_name)).to eq(true)
      end
    end

    context 'when the toggle is inactive' do
      before { allow(redis_database).to receive(:hget) { {active: false}.to_json } }

      it 'search the toggle on database' do
        expect(redis_database).to receive(:hget).with('chirrin-chirrion-toggles', toggle_name) { {active: false}.to_json }
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
