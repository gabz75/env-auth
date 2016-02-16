class V1::SessionsController < ApplicationController
  before_action :authenticate!, except: [:create]

  def show
  end

  def create
  end

  def destroy
  end

end
