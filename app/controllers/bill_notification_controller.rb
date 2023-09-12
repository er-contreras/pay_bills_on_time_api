class BillNotificationController < ApplicationController
  def create
    bill_name = bill_notification_params[:name]
    bill = Bill.find(bill_notification_params[:id])

    if bill
      # Toggle the bill_notification column
      BillNotification.find_by(bill_id: bill.id).toggle(:notification).save

      status = BillNotification.find_by(bill_id: bill.id).notification

      render json: {
        message: "Bill notifications are now #{status == true ? 'enabled' : 'disabled'} for #{bill_name}"
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
