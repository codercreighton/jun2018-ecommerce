class Product < ApplicationRecord
	belongs_to :category

	validates :category_id, presence: :true
	validates :image, presence: :true

	mount_uploader :image, ImageUploader
end
