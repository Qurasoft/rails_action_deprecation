class LinkController < ActionController::Base
  deprecate_endpoint DateTime.new(2022, 07, 02, 12, 34, 56), only: [:index, :show, :update], link: "https://github.com/Qurasoft/rails_action_deprecation"
  sunset_endpoint DateTime.new(2022, 07, 01, 12, 34, 56), only: [:show, :update, :destroy], link: "https://github.com/Qurasoft/teams_connector"

  def index
    render json: ['clean']
  end

  def show
    render json: 'clean'
  end

  def create
    render json: 'new'
  end

  def update
    render json: 'cleaner'
  end

  def destroy
    head :no_content
  end
end
