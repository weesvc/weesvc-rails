class Place < ApplicationRecord
    validates :name, uniqueness: true
end
