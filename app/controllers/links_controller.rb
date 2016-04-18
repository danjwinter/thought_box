require 'uri'

class LinksController < ApplicationController
  before_action :check_current_user

  def index
    @link ||= Link.new
    @links ||= current_user.links
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      binding.pry
      redirect_to link_path(@link)
    else
      @links = current_user.links
      render :index
    end
  end

  def show
    @link = current_user.links.find_by(id: params[:id])
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
