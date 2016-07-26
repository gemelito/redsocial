class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :item, polymorphic: true, index: true
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
=begin
	las relaciones pylymorphic
	genera dos campos
	->item_type
	->item_id
	apartir de estos se puede identificar a que table
	se hace la referencia
	->item_type = tabla
	->item_id = elemento de la table
	Estas relaciones se utilizan cuando se almace diferentes
	tipos de datos amigos,usuarios,posts

	index => para hacer mas facil las busquedas
=end
