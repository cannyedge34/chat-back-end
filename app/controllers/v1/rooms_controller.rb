class V1::RoomsController < ApplicationController
  before_action :set_room, only: %i[show update destroy]

  # GET /rooms
  def index
    @rooms = Room.all.paginate(page: params[:page], per_page: 10)
    json_response(@rooms)
  end

  # POST /rooms
  def create
    @room = current_user.rooms.create!(room_params)
    json_response(@room, :created)
  end

  # GET /rooms/:id
  def show
    json_response(@room)
  end

  # PUT /rooms/:id
  def update
    @room.update(room_params)
    head :no_content
  end

  # DELETE /rooms/:id
  def destroy
    @room.destroy
    head :no_content
  end

  private

  def room_params
    # whitelist params
    params.permit(:title)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
