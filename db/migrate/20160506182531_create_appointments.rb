class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :context_appointments do |t|
      t.references :context, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :role_name

      t.timestamps null: false
    end

    add_index "context_appointments", ["context_id", "user_id", "role_name"], name: "index_context_appointments_context_user_role", unique: true
#    add_index "context_appointments", ["context_id"], name: "index_context_appointments_on_context_id"
#    add_index "context_appointments", ["user_id"], name: "index_context_appointments_on_user_id"

  end
end
