class AddTermsAndSponsorToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :terms, :text

    add_column :admins, :sponsor, :string

  end
end
