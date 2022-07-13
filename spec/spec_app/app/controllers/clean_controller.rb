class CleanController < ActionController::Base
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
