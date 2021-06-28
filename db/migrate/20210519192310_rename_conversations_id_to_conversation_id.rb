class RenameConversationsIdToConversationId < ActiveRecord::Migration[5.1]
  def change
    rename_column :messages, :conversations_id, :conversation_id
    rename_column :messages, :users_id, :user_id
  end
end
