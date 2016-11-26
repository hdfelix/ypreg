require 'spec_helper'

describe UserDecorator do
  before(:example) do
    @user = FactoryGirl.create(:user).decorate
  end

  describe 'decorates the User class with' do
    it '#background_check_date_row_class' do
      expect(@user).to respond_to(:background_check_date_row_class)
    end

    it '#backgorund_check_date_bg_class' do
      expect(@user).to respond_to(:background_check_date_bg_class)
    end
  end

  context '#background_check_date_row_class' do
    it "returns and empty string if the user does not have a background check"  do
      @user.background_check_date = nil
      expect(@user.background_check_date_row_class).to eq 'danger'
    end

    it "returns 'an empty string' if background check is expired"  do
      @user.background_check_date = 40.months.ago
      expect(@user.background_check_date_row_class).to eq 'danger'
    end

    it "returns 'an empty string' if background check expires within 2 months" do
      @user.background_check_date = 35.months.ago
      expect(@user.background_check_date_row_class).to eq 'warning'
    end

    it "returns an empty string if background check has not expired \
        and won't expire for more than 2 months" do
      @user.background_check_date = 20.months.ago
      expect(@user.background_check_date_row_class).to eq ''
    end
  end

  context '#background_check_date_bg_class' do
    it "returns an empty string if the user does not have a background check" do
      @user.background_check_date = nil
      expect(@user.background_check_date_bg_class).to eq 'bg-danger'
    end

    it "returns and empty string if background check is expired"  do
      @user.background_check_date = 40.months.ago
      expect(@user.background_check_date_bg_class).to eq 'bg-danger'
    end

    it "returns and empty stringif background check expires within 2 months" do
      @user.background_check_date = 35.months.ago
      expect(@user.background_check_date_bg_class).to eq 'bg-warning'
    end

    it "returns an empty string if background check has not expired \
          and won't expire for more than 2 months" do
      @user.background_check_date = 20.months.ago
      expect(@user.background_check_date_bg_class).to eq ''
    end
  end
end
