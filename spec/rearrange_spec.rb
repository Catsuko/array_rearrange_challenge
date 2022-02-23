require 'spec_helper'
require 'timeout'
require 'my_solution'

RSpec.describe 'rearrange array' do
  subject { MySolution.rearrange(arr, offset) }

  context '[1, nil, nil]' do
    let(:arr) { [1, nil, nil] }

    context 'offsets [1, 0, 0]' do
      let(:offset) { [1, 0, 0] }

      it { is_expected.to eq [nil, 1, nil] }
    end

    context 'offsets [1, 1, 1]' do
      let(:offset) { [1, 1, 1] }

      it { is_expected.to eq [nil, 1, nil] }
    end

    context 'offsets [-1, 0, 0]' do
      let(:offset) { [-1, 0, 0] }

      it { is_expected.to eq arr }
    end

    context 'offsets [2, 0, 0]' do
      let(:offset) { [2, 0, 0] }

      it { is_expected.to eq [nil, nil, 1] }
    end

    context 'offsets [3, 0, 0]' do
      let(:offset) { [3, 0, 0] }

      it { is_expected.to eq arr }
    end
  end

  context '[1, 2, nil]' do
    let(:arr) { [1, 2, nil] }

    context 'offsets [1, 1, 1]' do
      let(:offset) { [1, 1, 1] }

      it { is_expected.to eq [nil, 1, 2] }
    end

    context 'offsets [-1, -1, -1]' do
      let(:offset) { [-1, -1, -1] }

      it { is_expected.to eq arr }
    end

    context 'offsets [1, -1, 0]' do
      let(:offset) { [1, -1, 0] }

      it { is_expected.to eq [2, 1, nil] }
    end

    context 'offsets [2, -1, 0]' do
      let(:offset) { [2, -1, 0] }

      it { is_expected.to eq [2, nil, 1] }
    end

    context 'offsets [1, -2, 0]' do
      let(:offset) { [1, -2, 0] }

      it { is_expected.to eq arr }
    end
  end

  context '[1, 2, 3]' do
    let(:arr) { [1, 2, 3] }

    context 'offsets [1, 1, 1]' do
      let(:offset) { [1, 1, 1] }

      it { is_expected.to eq arr }
    end

    context 'offsets [2, -1, -1]' do
      let(:offset) { [2, -1, -1] }

      it { is_expected.to eq [2, 3, 1] }
    end

    context 'offsets [1, -1, -1]' do
      let(:offset) { [1, -1, -1] }

      it { is_expected.to eq arr }
    end
  end

  context '[0, 1, 2, 3, 4, 5]' do
    let(:arr) { 6.times.to_a }

    context 'offsets by [1, -1, 1, -1, 1, -1]' do
      let(:offset) { [1, -1, 1, -1, 1, -1] }

      it { is_expected.to eq [1, 0, 3, 2, 5, 4] }
    end
  end

  describe 'performance' do
    let(:seconds_allowed) { 1 }

    [10, 100, 1000, 10000, 100_000].each do |n|

      context "n = #{n}" do
        let(:base_arr) { n.times.to_a }
        let(:arr) { base_arr + [nil] }
    
        context 'offsets by 1' do
          let(:offset) { [1] * arr.size }

          it "correct before timeout" do
            Timeout::timeout(seconds_allowed) { is_expected.to eq [nil] + base_arr }
          end
        end

        context 'offsets by -1' do
          let(:offset) { [-1] * arr.size }

          it "correct before timeout" do
            Timeout::timeout(seconds_allowed) { is_expected.to eq arr }
          end
        end
      end

    end
  end

end
