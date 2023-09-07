class BillsController < ApplicationController
  before_action :set_bill, only: %i[show update destroy]

  # GET /bills
  def index
    @bills = Bill.all

    render json: @bills
  end

  def user_bills
    @user_bills = Bill.where(user_id: params[:user_id])


    # Iterate over each bill
    @user_bills.each do |bill|
      deadline_date = Date.strptime(bill.date, '%d/%m/%Y')

      next unless deadline_date < Date.current

      # Calculate the new deadline date
      new_deadline_date = deadline_date.advance(months: 1)

      # Update the bill's deadline date
      bill.update(date: new_deadline_date.strftime('%d/%m/%Y'))
    end

    render json: @user_bills
  end

  # GET /bills/1
  def show
    render json: @bill
  end

  # POST /bills
  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      render json: @bill, status: :created, location: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bills/1
  def update
    if @bill.update(bill_params)
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bills/1
  def destroy
    @bill.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = Bill.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bill_params
    params.require(:bill).permit(:name, :date, :user_id)
  end
end
