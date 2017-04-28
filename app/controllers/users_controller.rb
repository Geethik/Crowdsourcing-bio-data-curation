class UsersController < ApplicationController
  include UsersHelper
  
  def show
    if session[:user_id] == nil
      flash[:warning] = "please login"
      redirect_to '/login'
      return
    end
    @user = User.find(session[:user_id])
    @submissions=Array.new
    @user.fullsubmissions.each do |sub|
      question=Fullquestion.find_by_id(sub.fullquestion_id)
      choice=nil
      if sub.choice=='1'
        choice='Yes'
      elsif sub.choice=='2'
        choice='No'
      else
        choice='Not available'
      end
      @submissions << {'question' => question.qcontent, 'accession' => question.ds_accession, 'choice' => choice, 'reason' => sub.reason}
    end
    @count=@user.get_submission_info['submission']
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to '/profile'
    else
      render 'new'
    end
  end
  
  def searchAll
    #debugger
    #@poweradmin = current_user
  end
  
   def save_search
        @dataset_results=Hash.new
        #@poweradmin = current_user
        #This func do two things: get result back from API 
        #+ save result to DB[partsearchresult]
        @attr_exper = params[:attr][:experSave]
        @attr_tech = params[:attr][:techSave]
        n_keyword = params[:searchSave]
        
        if(@attr_exper=='All assays by Molecule')
            @attr_exper=''
        end
        
        if(@attr_tech=='All technologies')
            @attr_tech=''
        end
        
        if(n_keyword!='')
            #debugger
            #n_keyword = params[:search]
            @previous_results = Savesearchresult.where("keyword=? AND filter_exper=? AND filter_tech=?",n_keyword,@attr_exper,@attr_tech)
            #p @previous_results.count
            if @previous_results.count > 0
                
                @dataset_results =  @previous_results.first.data_hash
                #p @dataset_results
            else
                @dataset_results = search_data_arrayexpress(n_keyword,@attr_exper,@attr_tech)
                @previous_results=nil    
            end
        else
            flash[:warning] = "Invalid search! Please enter the search term"
            redirect_to search_save_path
            return
        end
        
        if @dataset_results==nil||@dataset_results.empty?
            flash[:warning] = "No more dataset"
            redirect_to search_save_path
            return   
        end
        
        if params[:commit_save]=="save_back"
          @storage = Hash.new
          i=0
          @dataset_results.each do |k,v|
            if (!params[:selected_keys_save].nil? and params[:selected_keys_save].include?(k))
              @storage[k] = [v[0],v[1],v[2],v[3],v[4],"checked",params[:reasons][i]]
            else
              #if v[5]!="checked"
                @storage[k] = [v[0],v[1],v[2],v[3],v[4],"unchecked",params[:reasons][i]]
             # else
             #   @storage[k] = [v[0],v[1],v[2],v[3],v[4],"checked",params[:reasons][i]]
             # end
            end
            i=i+1
          end
          #p @storage
          Savesearchresult.where("keyword=? AND filter_exper=? AND filter_tech=?",n_keyword,@attr_exper,@attr_tech).first_or_create(keyword: n_keyword,
          filter_exper: @attr_exper, filter_tech: @attr_tech, data_hash: @storage).update(data_hash: @storage)
          flash[:warning] = "Curated results saved successfully!"
          redirect_to search_save_path
          return
        end
        render 'searchAll'
    end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:provider,:uid,:oauth_token,:oauth_expires_at)
    end
end
