class CreateDefaultAdmin < ActiveRecord::Migration[8.0]
  def up
    User.create!(
      name: "Admin",
      email: "admin@gmail.com",
      password: "adminpassword123",
      password_confirmation: "adminpassword123",
      role: "admin"
    ) unless User.exists?(email: "admin@gmail.com")
  end

  def down
    User.find_by(email: "admin@gmail.com")&.destroy
  end
end
