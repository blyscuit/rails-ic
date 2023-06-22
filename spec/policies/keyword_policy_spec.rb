# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordPolicy, type: :request do
  describe 'Scope' do
    context 'given a logged in user' do
      context 'given the user has keywords' do
        it 'allows user to get the keywords' do
          user = Fabricate(:user)
          keywords = Fabricate.times(3, :keyword, user: user)
          scope = described_class::Scope.new(user, Keyword).resolve

          expect(scope.to_a).to match_array(keywords)
        end
      end

      context 'given the user does not have keyword' do
        it 'return an empty array' do
          user = Fabricate(:user)
          Fabricate(:keyword)
          scope = described_class::Scope.new(user, Keyword).resolve

          expect(scope.to_a).to be_empty
        end
      end
    end
  end
end