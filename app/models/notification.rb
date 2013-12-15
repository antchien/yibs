class Notification < ActiveRecord::Base
  attr_accessible :link, :text, :user_id
end
