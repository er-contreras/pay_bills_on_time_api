class BillNotificationController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    bill_name = bill_notification_params[:name]
    bill_id = Bill.find(bill_notification_params[:id].to_i)

    if bill_id
      bill_notification = BillNotification.find_by(bill_id: bill_id.id)
      bill_notification.toggle(:notification).save

      status = bill_notification.notification

      render json: {
        message: "Bill notifications are now #{status ? 'enabled' : 'disabled'} for #{bill_name}",
        bill_notification_state: status
      }
    else
      render json: {
        message: "User with email #{bill_name} not found.",
        bill_notification_state: nil
      }, status: :not_found
    end
  end

  private

  def bill_notification_params
    params.require(:bill_notification_data).permit(:name, :id, :date, :userEmail)
  end
end
