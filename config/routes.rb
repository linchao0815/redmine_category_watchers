# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'category_watchers/:id', :to => 'category_watchers#index'
post 'category_watchers/add', :to => 'category_watchers#add'