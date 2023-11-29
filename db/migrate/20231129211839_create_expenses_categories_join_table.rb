class CreateExpensesCategoriesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses_categories, id: :primary_key do |t|
      t.references :category, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
    end
  end
end
