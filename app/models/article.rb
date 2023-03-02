class Article < ApplicationRecord
  extend FriendlyId

    validates :title, presence:true,length: {minimum:3, maximum:45}
    validates :body, presence:true , length: {minimum:1, maximu:300}
    belongs_to :user

    has_rich_text :body

    has_many :comments , dependent: :destroy

    has_noticed_notifications model_name: "Notification"
    has_many :notifications, through: :user

    friendly_id :title, use: %i[slugged history finders] # history to save old urls and redirect to the new url and finder here instead to change all Post.friendly.find(params[:id]) and just become Post.find(params[:id])

    def should_generate_new_friendly_id?
      title_changed? || slug.blank?
    end


end
