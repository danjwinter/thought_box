class Api::V1::LinksController < Api::ApiController
  respond_to :json

  def update
    respond_with Link.find(params[:id]).update_attributes(link_params)
  end

  private

  def link_params
    params.require(:link).permit(:read)
  end
end
