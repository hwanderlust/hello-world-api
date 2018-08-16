class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text
      t.references :chat
      t.references :sender
      t.references :recipient
      t.references :list
      t.timestamps
    end
  end
end
