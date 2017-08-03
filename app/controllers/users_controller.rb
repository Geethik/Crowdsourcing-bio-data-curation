class UsersController < ApplicationController
  include UsersHelper
  
    respond_to :csv
   @@set ||= Hash.new
   @@reference ||=''
   
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
    
    @users=Hash.new
    @result_datasets = Hash.new
    @attr_exper = params[:attr][:experSave]
    @attr_tech = params[:attr][:techSave]
    @ae_check =  params[:AE_check]
    @geo_check = params[:GEO_check]
    n_keyword = params[:csearchBox]
    
    if(@attr_exper=='All assays by Molecule')
          @attr_exper=''
    end
      
    if(@attr_tech=='All technologies')
          @attr_tech=''
    end  
    
    if params[:submit] == "Search database"
      if n_keyword==''
        flash[:warning] = "Invalid search! Please enter the search term"
        redirect_to search_save_path
        return
      end
      if @ae_check!='on' and @geo_check!='on'
        flash[:warning] = "Invalid search! Please select a database"
        redirect_to search_save_path
        return 
      end
      
    end
    
    if @geo_check=='on'
      @previous_results_geo =  Geosearchresult.where("keyword=?",n_keyword)
        
      if @previous_results_geo.count>0
        @result_datasets = @previous_results_geo.first.data_hash
      else
        @result_datasets = search_data_GEO(n_keyword)
        if @result_datasets==nil||@result_datasets.empty?
          flash[:warning] = "No more dataset"
          redirect_to search_save_path
          return
        end
        @previous_results_geo = nil
      end
      @@set = @result_datasets
      @@reference = "GEO"
      if params[:commit_save]=="save_back"
        @storage_geo = Hash.new
        i=0
        @result_datasets.each do |k,v|
          if (!params[:selected_keys_save_geo].nil? and params[:selected_keys_save_geo].include?(k))
            @storage_geo[k] = [v[0],v[1],v[2],v[3],v[4],"checked",params[:reasons_geo][i]]
          else
            # if v[5]!="checked"
            @storage_geo[k] = [v[0],v[1],v[2],v[3],v[4],"unchecked",params[:reasons_geo][i]]
            #else
            # @storage[k] = [v[0],v[1],v[2],v[3],v[4],"checked",params[:reasons][i]]
            #end
          end
          i=i+1
        end
        p @storage_geo
        Geosearchresult.where("keyword=?",n_keyword).first_or_create(keyword: n_keyword,data_hash: @storage_geo).update(data_hash: @storage_geo)
        flash[:warning] = "Curated results saved successfully!"
        redirect_to search_save_path
        return
      end
    end      
    if @ae_check=='on' 
    
      #debugger
      @previous_results = Savesearchresult.where("keyword=? AND filter_exper=? AND filter_tech=?",n_keyword,@attr_exper,@attr_tech)
      #p @previous_results.count
      if @previous_results.count > 10000
        @users =  @previous_results.first.data_hash
        #p @users
      else
        @users =  search_data_arrayexpress(n_keyword,@attr_exper,@attr_tech)
        if @users==nil||@users.empty?
          flash[:warning] = "No more dataset"
          redirect_to search_save_path
          return
        end
        @previous_results=nil    
      end
      @@set = @users
      @@reference = "Array Express"
      if params[:commit_save]=="save_back"
        @storage = Hash.new
        i=0
        @users.each do |k,v|
          if (!params[:selected_keys_save].nil? and params[:selected_keys_save].include?(k))
            @storage[k] = [v[0],v[1],v[2],v[3],v[4],v[5],"checked",params[:reasons][i]]
          else
            # if v[5]!="checked"
            @storage[k] = [v[0],v[1],v[2],v[3],v[4],v[5],"unchecked",params[:reasons][i]]
            #else
            # @storage[k] = [v[0],v[1],v[2],v[3],v[4],"checked",params[:reasons][i]]
            #end
          end
          i=i+1
        end
        p @storage
        Savesearchresult.where("keyword=? AND filter_exper=? AND filter_tech=?",n_keyword,@attr_exper,@attr_tech).first_or_create(keyword: n_keyword,
        filter_exper: @attr_exper, filter_tech: @attr_tech, data_hash: @storage).update(data_hash: @storage)
        flash[:warning] = "Curated results saved successfully!"
        
        redirect_to search_save_path
        return
      end
      
    end
    #p @@set
    #p @@reference
    render 'searchAll'
  end


def jsr

@data = Hash.new
@data = @@set

if(@@reference == "GEO")
  column_names = %w(GSE_ID Title Organism Release_Date Number_of_Samples Relevance Reason)
   
 csv_string = CSV.generate do |csv|
   

 csv << column_names
  @data.each do |k,v|
   csv << v
  end
end
else
 column_names = %w(Accession GSE_ID Name Type Organism Release_Date Assays Relevance Reason)
  csv_string = CSV.generate do |csv|
   

 csv << column_names
  @data.each do |k,v|
    a = Array.new
    a << k
    csv << a + v
  end
end
 end

  respond_to do |format|
    format.csv { render :csv => csv_string, :filename => "myfile.csv" }
  end
end






  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:provider,:uid,:oauth_token,:oauth_expires_at)
    end
    
   
end
