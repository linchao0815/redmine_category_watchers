class CategoryWatcher < ActiveRecord::Base
  unloadable
  attr_accessor :selected_users
   attr_accessor :category
#   attr_writer :category
end
