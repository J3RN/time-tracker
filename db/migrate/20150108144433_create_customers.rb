class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :company
      t.text :address1
      t.text :address2
      t.text :address3
      t.text :city
      t.text :state
      t.text :zip
      t.text :phone1
      t.text :phone2
      t.text :fax1
      t.text :fax2
      t.text :email
      t.text :website

      t.timestamps null: false
    end
  end
end
