# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  describe 'POST#signup' do
    context 'given valid email and password' do
      it 'returns http status of created' do
        post api_v1_signup_path, params: valid_signup_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'given duplicated email' do
      it 'returns http status of unprocessable content' do
        post api_v1_signup_path, params: duplicated_email_signup_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'given invalid client id' do
      it 'returns http status of unprocessable content' do
        post api_v1_signup_path, params: invalid_client_signup_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'given unmatched confirm password' do
      it 'returns http status of unprocessable content' do
        post api_v1_signup_path, params: confirm_password_not_matched_signup_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  private

  def valid_signup_params
    {
      email: "test+#{Time.now.to_i}@nimblehq.co",
      password: '123456',
      password_confirmation: '123456',
      client_id: 'sZl5c6GxwCI3YXuhSnjI6BiqfxQIy7wtobekdYu0k84'
    }
  end

  def duplicated_email_signup_params
    {
      email: 'test@nimblehq.co',
      password: '123456',
      password_confirmation: '123456',
      client_id: 'sZl5c6GxwCI3YXuhSnjI6BiqfxQIy7wtobekdYu0k84'
    }
  end

  def invalid_client_signup_params
    {
      email: 'test@nimblehq.co',
      password: '123456',
      password_confirmation: '123456',
      client_id: 'client_id'
    }
  end

  def confirm_password_not_matched_signup_params
    {
      email: "test+#{Time.now.to_i}@nimblehq.co",
      password: '123456',
      password_confirmation: '12456',
      client_id: 'client_id'
    }
  end
end
