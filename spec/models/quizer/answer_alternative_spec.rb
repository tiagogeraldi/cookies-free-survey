require 'rails_helper'

RSpec.describe Quizer::AnswerAlternative, type: :model do
  it { is_expected.to belong_to(:answer) }
  it { is_expected.to belong_to(:alternative) }
end
