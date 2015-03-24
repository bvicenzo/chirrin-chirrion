require 'spec_helper'

describe ChirrinChirrion do
  let(:database_adapter) { double }

  describe ".add_toggle" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the database adapter returns ok' do
      before { allow(database_adapter).to receive(:add_toggle) { true } }

      it 'returns true' do
        expect(subject.add_toggle(toggle_name)).to eq(true)
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:add_toggle) { false } }

      it 'returns false' do
        expect(subject.add_toggle(toggle_name)).to eq(false)
      end
    end
  end

  describe ".remove_toggle" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the database adapter returns ok' do
      before { allow(database_adapter).to receive(:remove_toggle) { true } }

      it 'returns true' do
        expect(subject.remove_toggle(toggle_name)).to eq(true)
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:remove_toggle) { false } }

      it 'returns false' do
        expect(subject.remove_toggle(toggle_name)).to eq(false)
      end
    end
  end

  describe ".chirrin" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the database adapter returns ok' do
      before { allow(database_adapter).to receive(:activate) { true } }

      it 'returns true' do
        expect(subject.chirrin(toggle_name)).to eq(true)
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:activate) { false } }

      it 'returns false' do
        expect(subject.chirrin(toggle_name)).to eq(false)
      end
    end
  end

  describe ".chirrion" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the database adapter returns ok' do
      before { allow(database_adapter).to receive(:inactivate) { true } }

      it 'returns true' do
        expect(subject.chirrion(toggle_name)).to eq(true)
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:inactivate) { false } }

      it 'returns false' do
        expect(subject.chirrion(toggle_name)).to eq(false)
      end
    end
  end

  describe ".chirrin?" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the database adapter returns ok' do
      before { allow(database_adapter).to receive(:active?) { true } }

      it 'returns true' do
        expect(subject.chirrin?(toggle_name)).to eq(true)
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:active?) { false } }

      it 'returns false' do
        expect(subject.chirrin?(toggle_name)).to eq(false)
      end
    end
  end

  describe ".chirrion?" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the database adapter returns ok' do
      before { allow(database_adapter).to receive(:inactive?) { false } }

      it 'returns false' do
        expect(subject.chirrion?(toggle_name)).to eq(false)
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:inactive?) { true } }

      it 'returns true' do
        expect(subject.chirrion?(toggle_name)).to eq(true)
      end
    end
  end

  describe ".chirrin_chirrion" do
    let(:toggle_name) { 'my_toggle' }
    before { ChirrinChirrion.config(database_adapter: database_adapter) }

    context 'when the toggle is turned on' do
      before { allow(database_adapter).to receive(:active?) { true } }

      context 'and instruction for chirrin is not a proc' do
        let(:for_chirrin) { 'Margarida' }
        let(:for_chirrion) { 'Este idiota' }

        it 'returns for chirrin value' do
          expect(subject.chirrin_chirrion(toggle_name, for_chirrin, for_chirrion)).to eq('Margarida')
        end
      end

      context 'and instruction for chirrin is a proc' do
        let(:for_chirrin) { lambda { 'Margarida, Chirrin!!!!' } }
        let(:for_chirrion) { lambda { 'Este idiota, Chirrion!!!!' } }

        it 'executes chirrin proc' do
          expect(subject.chirrin_chirrion(toggle_name, for_chirrin, for_chirrion)).to eq('Margarida, Chirrin!!!!')
        end
      end
    end

    context 'when the database adapter returns nok' do
      before { allow(database_adapter).to receive(:active?) { false } }

      context 'and instruction for chirrin is not a proc' do
        let(:for_chirrin) { 'Margarida' }
        let(:for_chirrion) { 'Este idiota' }

        it 'returns for chirrion value' do
          expect(subject.chirrin_chirrion(toggle_name, for_chirrin, for_chirrion)).to eq('Este idiota')
        end
      end

      context 'and instruction for chirrin is a proc' do
        let(:for_chirrin) { lambda { 'Margarida, Chirrin!!!!' } }
        let(:for_chirrion) { lambda { 'Este idiota, Chirrion!!!!' } }

        it 'executes chirrin proc' do
          expect(subject.chirrin_chirrion(toggle_name, for_chirrin, for_chirrion)).to eq('Este idiota, Chirrion!!!!')
        end
      end
    end
  end
end
