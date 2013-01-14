class Post < ActiveRecord::Base
  attr_accessible :body, :private, :title
end
