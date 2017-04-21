class CreateLibraryEvents < ActiveRecord::Migration
  def change
    # not needed anymore, will be repalced with LibraryEvents
    drop_table(:marathon_events , if_exists: true)
    drop_table(:marathons , if_exists: true)

    create_table :library_events do |t|
      t.references :library_entry, foreign_key: true, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.integer :anime_id, index: true
      t.integer :manga_id, index: true
      t.integer :drama_id, index: true
      # not adding null constraints or defaults
      # because this is coming from library_entry,
      # so it should have all valid fields where needed
      t.text :notes
      t.boolean :nsfw
      t.boolean :private
      t.integer :progress
      t.integer :rating
      t.boolean :reconsuming
      t.integer :reconsume_count
      t.integer :volumes_owned
      t.integer :time_spent
      t.integer :status
      # new columns
      t.integer :event, null: false
      t.jsonb :changed_data, default: {}, null: false

      t.timestamps null: false
    end
  end
end