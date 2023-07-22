class BillNotificationController < ApplicationController
  def create
    bill_date = bill_notification_params[:date]

    # EmailJob.perform_async(bill_date)
    render json: { message: "Bill notification request has been received to be every month in #{bill_date}" }
  end

  private

  def bill_notification_params
    params.require(:bill_notification_data).permit(:name, :id, :date)
  end
end
