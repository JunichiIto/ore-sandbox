require 'active_support/core_ext/object'
require 'spec_helper'

describe Ore do
  describe '#first_name' do
    let(:ore) { Ore.new(last_name) }
    let(:last_name) { nil }
    subject { ore.first_name }
    context 'when Matsuyama' do
      let(:last_name) { 'Matsuyama' }
      it { is_expected.to eq 'Hideyuki' }
    end
    context 'when 松山' do
      let(:last_name) { '松山' }
      it { is_expected.to eq '秀行' }
    end
    context 'when Foo' do
      let(:last_name) { 'Foo' }
      it { is_expected.to eq '(Unknown)' }
    end
    context 'when だれだれ' do
      let(:last_name) { 'だれだれ' }
      it { is_expected.to eq '(Unknown)' }
    end
    context 'when Foo' do
      let(:last_name) { 'Foo' }
      it { is_expected.to eq '(Unknown)' }
    end
    context 'when file_path is nil' do
      before do
        allow(ore).to receive(:file_path).and_return(nil)
      end
      it 'raises error' do
        expect{ore.first_name}.to raise_error(TypeError)
      end
    end
    context 'when file does not exist' do
      let(:last_name) { '松山' }
      before do
        path = File.expand_path("../../config/foo.yml", __FILE__)
        allow(ore).to receive(:file_path).and_return(path)
      end
      it { is_expected.to be_nil }
      it 'gives message' do
        expect{ore.first_name}.to \
          output(/foo\.yml' is not found\./).to_stdout
      end
    end
  end
end