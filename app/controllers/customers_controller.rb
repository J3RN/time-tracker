require 'csv'

class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @customers = Customer.all
    respond_with(@customers)
  end

  def show
    respond_with(@customer)
  end

  def new
    @customer = Customer.new
    respond_with(@customer)
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.save
    respond_with(@customer)
  end

  def update
    @customer.update(customer_params)
    respond_with(@customer)
  end

  def destroy
    @customer.destroy
    respond_with(@customer)
  end

  def import
    uploaded_io = params[:import_data]
    new_path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(new_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    CSV.foreach(new_path, row_sep: :auto) do |row|
      if (row.reduce {|x, y| x || y})
        row.unshift(nil)
        model_hash = row.each_with_index.map {|item, index| [Customer.column_names[index], item]}.to_h

        Customer.create!(model_hash)
      end
    end

    redirect_to customers_path
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:company, :address1, :address2, :address3, :city, :state, :zip, :phone1, :phone2, :fax1, :fax2, :email, :website)
    end
end
