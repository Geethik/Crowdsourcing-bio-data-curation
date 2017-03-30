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
    @poweradmin = current_user
  end
  
   def saveSearch
        @dataset=Hash.new
        @poweradmin = current_user
        #This func do two things: get result back from API 
        #+ save result to DB[partsearchresult]
        @attr_exper = params[:attr][:experSave]
        @attr_tech = params[:attr][:techSave]
        n_keyword = params[:searchSave]
        
        if(@attr_exper!='All assays by Molecule')
            n_keyword=n_keyword+'+'+@attr_exper
        end
        
        if(@attr_tech!='All technologies')
            n_keyword=n_keyword+'+'+@attr_tech
        end
        
        if(n_keyword!='')
            #debugger
            #n_keyword = params[:search]
            @previous_record = Partsearchresult.where(:keyword => n_keyword)
            if @previous_record.count > 0
                @new_temp_record = @previous_record.first
                @all_dataset = @previous_record.first.Data_set_results
                @previous_dataset= Dataset.find_by_name(n_keyword).Data_set
                @all_dataset.each do |k,v|
                    if !@previous_dataset.has_key?(k)
                        @dataset[k]=v
                    end
                    if params[:submit]=="Search"&&@dataset.length >= 20
                        break
                    end
                end
            else
                @dataset_raw = search_data_arrayexpress(n_keyword)
                if(n_keyword != "")
                    @new_temp_record = Partsearchresult.create(keyword: n_keyword, Data_set_results: @dataset_raw)
                    Dataset.create(name:n_keyword)
                    @previous_dataset=nil
                else
                    flash[:warning] = "invalid search term"
                    redirect_to search_save_path
                    return  
                end
                dataset_foruse = Hash.new
                @dataset_raw.each do |k,v|
                    dataset_foruse[k] = v
                    
                  if params[:submit]=="Search"&&dataset_foruse.length >= 20
                    break
                  end
                end                
                @dataset = dataset_foruse    
            end
        else
            redirect_to search_save_path
            return
        end
        if @dataset==nil||@dataset.empty?
            flash[:warning] = "No more dataset"
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
