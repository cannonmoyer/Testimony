class Story < ActiveRecord::Base
	validates :name, presence: true
	validates :title, presence: true
	validates :content, presence: true
	
	belongs_to :user
end
