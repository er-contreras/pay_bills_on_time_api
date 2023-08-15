class BillNotificationController < ApplicationController
  def create
    id = bill_notification_params[:id]
    name = bill_notification_params[:name]
    bill_date = bill_notification_params[:date]
    email = bill_notification_params[:userEmail]

    EmailJob.perform_async(email, bill_date)

    render json: {
      message:
        "Bill notification request has been received to ID: #{id}, Name: #{name}, Date: #{bill_date}, Email: #{email}"
    }
  end

  private

  def bill_notification_params
    params.require(:bill_notification_data).permit(:name, :id, :date, :userEmail)
  end
end
