class CategoryWatchersController < ApplicationController
  unloadable

  before_filter :authorize_cw, :only => [:add, :index]

  def index
    @project = Project.find(params[:id])
    @users = @project.users

    categories_tmp = IssueCategory.where(project_id:@project.id)
    

    @category_watchers_array = []
    

    categories_tmp.each do |category|
      cw = CategoryWatcher.where(category_id:category.id).first
      
      if cw.nil?
        cw = CategoryWatcher.create 
        cw.watchers = " "
      end

      #get users from id and add them to cw
      #selected_users = cw.watchers.split.map{|id| id.to_i}
      #ids = cw.watchers.split(',')
      #selected_users = User.where(id:ids).map{|user| user.id}
       
      cw.watchers = cw.watchers.split(",")
      @category_watchers_array << {category_watcher:cw, category:category}
      
    end

   end


  def add

      params.each do |key, value|
        if key.include? 'watchers_'
          category_id = key.sub('watchers_','')

          #category = IssueCategory.find category_id
          
          cw = CategoryWatcher.where(category_id:category_id).first
          
          if(cw.nil?)
            cw = CategoryWatcher.create 
            cw.category_id = category_id
          end

          if value.kind_of?(Array)

            value.delete_at(0) if value.size > 1 #  "watchers_52"=>["", "15", "10"] to remove the first that is empty

            if value.any?
              cw.watchers = value.join(",")
            else
              cw.watchers = ""
            end

          end

          cw.save
          flash[:notice] = l(:watchers_saved) if cw.save

        end  
    end

    redirect_to :action => "index", id:params[:project]

  end
    

  private
  def authorize_cw
    allowed = case params[:action].to_s
      when "add"
        User.current.allowed_to?(:add_category_watchers, nil, {global:true})
      when "index"
        User.current.allowed_to?(:access_category_watchers, nil, {global:true})
      else
        false
    end

    if allowed
      true
    else
      deny_access
    end
    
  end


end
