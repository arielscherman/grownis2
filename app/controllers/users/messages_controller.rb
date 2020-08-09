class Users::MessagesController < ApplicationController
  before_action :authenticate_user!

  def update
    @message = User::Message.find(params[:id])
    @message.update(message_params)

    render :update, locals: { message: @message }
  end

  private

  def message_params
    params.require(:message).permit(:acknowledged)
  end
end
