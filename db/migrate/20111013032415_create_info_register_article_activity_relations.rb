class CreateInfoRegisterArticleActivityRelations < ActiveRecord::Migration
  def change
    create_table :info_register_article_activity_relations do |t|
      t.references :article
      t.references :activity
      t.string :result, :default=>'create'
      t.references :reviewer
      t.text :remark
      t.datetime :review_time
      t.timestamps
    end
    add_index :info_register_article_activity_relations, :article_id
    add_index :info_register_article_activity_relations, :activity_id
    add_index :info_register_article_activity_relations, :reviewer_id
  end
end
