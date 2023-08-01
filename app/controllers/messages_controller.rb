class MessagesController < ApplicationController
  
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.inculde(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redilect_to room_messages_path(@room)
    else
      @messages = @room.messages.inculde(:user)
      render :index, status: :unprocessable_entity
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
