
module RedmineCategoryWatchers
  class Hooks < Redmine::Hook::ViewListener
    

  	# def controller_issues_new_before_save(context)
  	# 	context[:issue][:mail] = User.current.mail unless User.current == nil
  	# end

  	def controller_issues_new_after_save(context)
  		issue = Issue.find(context[:issue])
  		
      auto_watch issue
      issue.save
      
	  end


  		
    def auto_watch(issue)
      unless issue.category_id.nil?

       cw = CategoryWatcher.where(category_id:issue.category_id).first
       unless cw.nil?
       	watchers = cw.watchers.split ','
	
       	watchers.each do |id|
           user = User.find(id.to_i)
           issue.add_watcher user
         end
       
       end

      end
    end

    
  end
end