json.array!(@customers) do |customer|
  json.extract! customer, :id, :company, :address1, :address2, :address3, :city, :state, :zip, :phone1, :phone2, :fax1, :fax2, :email, :website
  json.url customer_url(customer, format: :json)
end
