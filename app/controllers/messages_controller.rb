class MessagesController < ApplicationController
  attr_reader :message
  load_and_authorize_resource

  def new; end

  def create
    if message.save
      flash[:info] = t "create_mess"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit :body
  end
end
