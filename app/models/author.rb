class Author < ActiveRecord::Base
    #author is invalid without a name
    #author is invalide when not unique
    #auther phone number must have a length of 10
    validates :name, presence: true, uniqueness: true
    validates :phone_number, length: { is: 10 }
end
