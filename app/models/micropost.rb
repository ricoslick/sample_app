class Micropost < ApplicationRecord
	include ActiveModel::ForbiddenAttributesProtection
	belongs_to :user

	validates(:user_id, presence: true)

	default_scope order: 'microposts.created_at DESC'
end
