class AddClientToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :sitter, :integer
  end
end
