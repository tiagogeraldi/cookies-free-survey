require 'rails_helper'

RSpec.describe Quizer::Answer, type: :model do
  let(:question) { create(:question, question_type: 'open_ended') }

  subject { described_class.new(question: question) }

  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:quiz) }
  it { is_expected.to have_many(:answer_alternatives) }
  it { is_expected.to have_many(:alternatives) }

  it { is_expected.to validate_presence_of(:session_hex) }
  it { is_expected.to validate_presence_of(:quiz) }
  it { is_expected.to validate_presence_of(:question) }
  it { is_expected.to validate_presence_of(:descriptive) }

  describe '.count_by_session' do
    it 'counts distinct' do
      create :answer, session_hex: 'a'
      create :answer, session_hex: 'a'
      create :answer, session_hex: 'b'

      expect(described_class.count_by_session).to eq 2
    end
  end

  describe 'at_least_one_alternative' do
    before do
      subject.alternatives = []
    end

    it 'sets error select_one' do
      question.question_type = 'select_one'
      expect(subject.valid?).to eq false
      expect(subject.errors[:base]).to include 'Select one alternative'
    end

    it 'sets error select_one_or_more' do
      question.question_type = 'select_one_or_more'
      expect(subject.valid?).to eq false
      expect(subject.errors[:base]).to include 'Select one or more alternatives'
    end
  end
end
