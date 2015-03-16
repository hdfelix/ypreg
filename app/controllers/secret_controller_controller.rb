# this controller is named incorrectly.
class SecretControllerController < ApplicationController
  http_basic_authenticate_with name: 'hdfelix', password: 'chiracha'

  def index
  end
end
