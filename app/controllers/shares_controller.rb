class SharesController < ApplicationController
  before_action :set_share, only: %i[ show update destroy ]

  # GET /shares
  def index
    @shares = Share.all

    render json: @shares
  end

  # GET /shares/1
  def show
    render json: @share
  end

  # POST /shares
  def create
    @share = Share.new(share_params)

    if @share.save
      render json: @share, status: :created, location: @share
    else
      render json: @share.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shares/1
  def update
    if @share.update(share_params)
      render json: @share
    else
      render json: @share.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shares/1
  def destroy
    @share.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share
      @share = Share.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def share_params
      params.require(:share).permit(:post_id, :user_id)
    end
end
