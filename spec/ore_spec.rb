require 'active_support/core_ext/object'
require 'spec_helper'

describe Ore do
  describe '.firstname' do
    subject { Ore.firstname lastname }

    context 'when lastname is "Matsuyama"' do
      let(:lastname) { 'Matsuyama' }
      it { is_expected.to eq 'Hideyuki' }
    end

    context 'when lastname is "松山"' do
      let(:lastname) { '松山' }
      it { is_expected.to eq '秀行' }
    end

    context 'when lastname is "Foo"' do
      let(:lastname) { 'Foo' }
      it { is_expected.to eq '(Unknown)' }
      it 'should receive .怪しむ' do
        expect(Ore).to receive(:怪しむ).with(lastname); subject
      end
    end
  end

  describe '.load_file' do
    let(:target_filepath) { puts __FILE__; File.expand_path("../../config/ore.yml", __FILE__) }

    subject { Ore.load_file target_filepath }

    it { is_expected.to be_present }

    context 'when the loading filepath is nil' do
      let(:target_filepath) { nil }

      it 'should does not printing message, and raise error' do
        expect do
          expect(Ore).not_to receive(:print_message)
          subject
        end.to raise_error
      end
    end

    context 'when the loading filepath does not exist' do
      let(:target_filepath) { 'not_exist_filepath.yml' }

      it 'should printing message, and does not raise error' do
        expect do
          expect(Ore).to receive(:print_message).with(target_filepath)
          subject
        end.not_to raise_error
      end
    end
  end

  describe '.怪しむ' do
    subject { Ore.怪しむ lastname }

    context 'when lastname is "オレオレ"' do
      let(:lastname) { 'オレオレ' }
      it { is_expected.to eq '詐欺かも' }
    end

    context 'when lastname is "だれだれ"' do
      let(:lastname) { 'だれだれ' }
      it { is_expected.to eq '(Unknown)' }
    end
  end
end