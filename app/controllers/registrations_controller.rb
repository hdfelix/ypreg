class RegistrationsController < ApplicationController
  def index
  end

	def new
		@registration = Registration.new
	end

	def create
	end
end
