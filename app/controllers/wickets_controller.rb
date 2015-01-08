class WicketsController < ApplicationController
  before_action :set_wicket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @wickets = Wicket.all
    respond_with(@wickets)
  end

  def show
    respond_with(@wicket)
  end

  def new
    @wicket = Wicket.new
    respond_with(@wicket)
  end

  def edit
  end

  def create
    @wicket = Wicket.new(wicket_params)
    @wicket.user = current_user
    @wicket.save
    respond_with(@wicket)
  end

  def update
    @wicket.update(wicket_params)
    respond_with(@wicket)
  end

  def destroy
    @wicket.destroy
    respond_with(@wicket)
  end

  private
    def set_wicket
      @wicket = Wicket.find(params[:id])
    end

    def wicket_params
      params.require(:wicket).permit(:name, :part_number, :user_id)
    end
end
