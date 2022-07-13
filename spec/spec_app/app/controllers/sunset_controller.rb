class SunsetController < ActionController::Base
  sunset_endpoint DateTime.new(2022, 07, 01, 12, 34, 56)

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
