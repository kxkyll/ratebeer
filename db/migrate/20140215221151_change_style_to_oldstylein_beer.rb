class ChangeStyleToOldstyleinBeer < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :oldstyle
  end
end
