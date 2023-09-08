namespace :populate_bill_notifications do
  desc 'Populate bill_notifications for all users'
  task all_users: :environment do
    User.find_each do |user|
      user.bills.each do |bill|
        BillNotification.find_or_create_by(bill_id: bill.id)
      end
    end
  end
end
