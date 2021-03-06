require 'uri'

class LinksController < ApplicationController
  before_action :check_current_user

  def index
    @link ||= Link.new
    @links = current_user.links
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to link_path(@link)
    else
      @links = current_user.links
      render :index
    end
  end

  def edit
    @link = current_user.links.find_by(id: params[:id])
  end

  def update
    @link = current_user.links.find_by(id: params[:id])

    if @link.update_attributes(link_params)
      redirect_to links_path
    else
      render :edit
    end
  end

  def show
    @link = current_user.links.find_by(id: params[:id])
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
