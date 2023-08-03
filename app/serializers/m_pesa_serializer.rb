class MPesaSerializer < ActiveModel::Serializer
  attributes :id, :checkoutRequestID, :merchantRequestID, :amount, :mpesaReceiptNumber, :phoneNumber
  has_one :user
end
