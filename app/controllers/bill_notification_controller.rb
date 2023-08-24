class BillNotificationController < ApplicationController
  def create
    bill_date = bill_notification_params[:date]
    email = bill_notification_params[:userEmail]

    EmailJob.perform_at(bill_date.to_datetime, email, bill_date)

    render json: {
      message:
        "Bill notification request has been received to Date: #{bill_date}, Email: #{email}"
    }
  end

  private

  def bill_notification_params
    params.require(:bill_notification_data).permit(:name, :id, :date, :userEmail)
  end
end
