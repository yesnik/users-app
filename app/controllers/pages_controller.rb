class PagesController < ApplicationController
  before_action :authenticate_user!, only: :welcome

  def home; end

  def welcome; end
end
