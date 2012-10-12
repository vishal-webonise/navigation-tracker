class StaticPagesController < ApplicationController
  before_filter :is_signed_in?, only: [:home]

  def home
  end

  def feature
  end

  private

  def is_signed_in?
    if user_signed_in?
      redirect_to dashboard_index_path
    end
  end
end