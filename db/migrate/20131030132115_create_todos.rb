class CreateTodos < ActiveRecord::Migration
  def up
  	create_table :todos do |t|
  	t.string :text
  	t.integer :status

  	end
  	
  end

  def down
  end
end
