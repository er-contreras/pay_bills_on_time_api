class CreateBillNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :bill_notifications do |t|
      t.bigint :bill_id
      t.boolean :notification, default: false

      t.timestamps
    end

    add_foreign_key :bill_notifications, :bills
  end
end
