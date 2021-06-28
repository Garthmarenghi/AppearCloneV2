class MessagesController < ApplicationController
  before_action :ensure_authenticated
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    redirect_to root_path unless current_user == User.find(@conversation.sender_id) || current_user == User.find(@conversation.recipient_id)
  end

  def index
    @messages = @conversation.messages
    @message = @conversation.messages.new
    if current_user == User.find(@conversation.recipient_id)
      @user = User.find(@conversation.sender_id)
    else
      @user = User.find(@conversation.recipient_id)
    end
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

end
