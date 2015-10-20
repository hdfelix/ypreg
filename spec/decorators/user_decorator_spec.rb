require 'spec_helper'

describe UserDecorator do
  before(:example) do
    @user = FactoryGirl.create(:user).decorate
  end

  describe 'decorates the User class with' do
    it '#background_check_date_row_class' do
      expect(@user).to respond_to(:background_check_date_row_class)
    end

    it '#backgorund_check_date_gb_class' do
      expect(@user).to respond_to(:background_check_date_bg_class)
    end
  end

  context '#background_check_date_row_class' do
    it "returns 'danger' if the user does not have a background check"  do
      @user.background_check_date = nil
      expect(@user.background_check_date_row_class).to eq 'danger'
    end

    it "returns 'danger' if background check is expired"  do
      @user.background_check_date = 40.months.ago 
      expect(@user.background_check_date_row_class).to eq 'danger'
    end

    it "returns 'warning' if background check expires within 2 months" do
      @user.background_check_date = 35.months.ago 
      expect(@user.background_check_date_row_class).to eq 'warning'
    end

    it "does not return a class name if background check has not expired \
        and won't expire for more than 2 months" do
      @user.background_check_date = 20.months.ago 
      expect(@user.background_check_date_row_class).to eq ''
    end
  end

  context '#background_check_date_bg_class' do
    it "that returns 'danger' if the user does not have a background check"  do
      @user.background_check_date = nil
      expect(@user.background_check_date_bg_class).to eq 'bg-danger'
    end

    it "that returns 'danger' if background check is expired"  do
      @user.background_check_date = 40.months.ago 
      expect(@user.background_check_date_bg_class).to eq 'bg-danger'
    end

    it "that returns 'warning' if background check expires within 2 months" do
      @user.background_check_date = 35.months.ago 
      expect(@user.background_check_date_bg_class).to eq 'bg-warning'
    end

    it "that does not return a class name if background check has not expired \
          and won't expire for more than 2 months" do
      @user.background_check_date = 20.months.ago 
      expect(@user.background_check_date_bg_class).to eq ''
    end
  end
end
