class AddSubdomainToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :subdomain, :string

  end
end
