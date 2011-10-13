class CreateInfoRegisterArticles < ActiveRecord::Migration
  def change
    create_table :info_register_articles do |t|
      t.references :owner
      t.string :title
      t.string :publication_name
      t.string :publish_date
      t.string :person_rank
      t.string :publication_type
      t.string :upload_time
      t.string :name
      t.string :file_name

      t.timestamps
    end
    add_index :info_register_articles, :owner_id
  end
end
