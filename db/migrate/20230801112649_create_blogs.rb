class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.text :article
      t.references :user
      t.string :slug
      t.boolean :is_active, default: true
      t.boolean :is_published, default: false

      t.timestamps
    end
  end
end
