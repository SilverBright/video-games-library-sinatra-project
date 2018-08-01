class RenameTitlesColumnToTitle < ActiveRecord::Migration
  def change
  	rename_column :games, :titles, :title
  end
end
