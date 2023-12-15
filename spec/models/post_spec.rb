require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'validação inicial' do
    expect(1).to eq(1)
  end

  it 'validação final' do
    expect(1).to eq(2)
  end
end
