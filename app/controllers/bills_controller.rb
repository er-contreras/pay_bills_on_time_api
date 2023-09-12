class BillsController < ApplicationController
  before_action :set_bill, only: %i[show update destroy]

  def index
    @bills = Bill.all

    render json: @bills
  end

  def user_bills
    @user_bills = Bill.where(user_id: params[:user_id])

    @user_bills.each do |bill|
      deadline_date = Date.strptime(bill.date, '%d/%m/%Y')

      next unless deadline_date < Date.current

      new_deadline_date = deadline_date.advance(months: 1)
      bill.update(date: new_deadline_date.strftime('%d/%m/%Y'))
    end

    render json: @user_bills
  end

  def show
    render json: @bill
  end

  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      render json: @bill, status: :created, location: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bill.update(bill_params)
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bill.destroy
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(:name, :date, :user_id)
  end
end
