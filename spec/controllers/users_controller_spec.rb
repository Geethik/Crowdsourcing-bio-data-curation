require 'rails_helper'

describe UsersController do
  
  it "Renders with GEO filters checked" do
    params = {:GEO_exp_1 =>'on',:GEO_exp_2 => 'on', :GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on'}
    
    post :searchAll, params
    expect(response).to render_template('searchAll')
  end
    
	it "Renders the searchAll template" do
   	params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis',:AE_check => 'on',:submit => "Search database"}
  	 
   	post :save_search, params
   	expect(response).to render_template('searchAll')
   	
	end
    
	it "Receives the relevant filters from params" do
   	 
    	params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis',:AE_check => 'on', :submit => "Search database"}
   	 
    	post :save_search, params
    	expect(assigns(:attr_exper)).to eq('RNA assay')
    	expect(assigns(:attr_tech)).to eq('Sequencing assay')
	end
	
	
  it "Filters using Experiment type" do
    	params = {:attr => {:experSave => 'RNA assay', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',:AE_check => 'on', :submit => "Search database"}
   	 
    	post :save_search, params
    	expect(assigns(:attr_exper)).to eq('RNA assay')
    	expect(assigns(:users)).not_to eq(nil)
  end
  
  
  it "Filters using Technology type" do
    	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis',:AE_check => 'on', :submit => "Search database"}
   	 
    	post :save_search, params
    	expect(assigns(:attr_tech)).to eq('Sequencing assay')
    	expect(assigns(:users)).not_to eq(nil)
  end
  
  
  it "Searched by keyword alone without filters" do
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',:AE_check => 'on', :submit => "Search database"}
   	 
    	post :save_search, params
    	expect(assigns(:users)).not_to eq(nil)
  end
  
	it "Redirects if it receives an invalid search due to keyword " do
   	 
    	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => '',:AE_check => 'on', :submit => "Search database" }
   	 
    	post :save_search, params
    	expect(response).to redirect_to('/searchAll')
    	flash[:warning].should eq("Invalid search! Please enter the search term")
    	#expect(response.status).to eq(302)
  	end
    
	it "Should query Savesearchresult for the stored results" do
  	 
   	params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis',:AE_check => 'on', :submit => "Search database
   	" }
  	 
   	post :save_search, params
   	expect(assigns(:users)).not_to eq(nil)
  	 
	end
	
	it "Should give no datatsets array express" do
	  params = {:attr => {:experSave => 'DNA assay', :techSave => 'Mass spectrometry assay'}, :csearchBox => 'eye',:AE_check =>'on', :submit => "Search database" }
	  
	  post :save_search,params
	  expect(assigns(:dataset_results)).to eq(nil)
	  expect(response).to redirect_to('/searchAll')
	   flash[:warning].should eq("No more dataset")
  end
  
  	it "Should give no datatsets GEO" do
	  params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'heeehe',:GEO_check =>'on', 
	  :GEO_exp_1 =>'on',:GEO_exp_2 =>'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on',:submit => "Search database" }
	  
	  post :save_search,params
	  #expect(assigns(:result_datasets)).to eq(nil)
	  expect(response).to redirect_to('/searchAll')
	   flash[:warning].should eq("No more dataset")
  end
  
      
  	it "Should retrieve data from Savesearchresult model" do
      params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis', :AE_check => 'on', :submit => "Search database", :commit_save => 'save_back', :selected_keys_save => 'E-MTAB-5287' ,:reasons => ''}
      post :save_search,params
      params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis', :AE_check => 'on' , :submit => "Search database"}
      post :save_search,params
      expect(assigns(:previous_results)).not_to eq(nil)
	  end
      
    it "Should save the search made by the user" do
    
    params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :csearchBox => 'tuberculosis',:AE_check =>'on', :submit => "Search database", :commit_save => 'save_back', :selected_keys_save => 'E-MTAB-5287' ,:reasons => ''}
    
    post :save_search, params
    
    flash[:warning].should eq("Curated results saved successfully!")
    end
    
    it "GEO Renders the searchAll template" do
   	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',:GEO_check =>'on', 
   	  :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on', :submit => "Search database"}
  	 
   	post :save_search, params
   	expect(response).to render_template('searchAll')
	end
	
	it "GEO searches based on Organism filters Homosapiens" do
	  params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',:GEO_check =>'on', 
   	  :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on', :submit => "Search database"}
  	 
   	post :save_search, params
    expect(assigns(:result_datasets)).not_to eq(nil)
	end
	
	
	it "GEO searches based on Organism filters Mouse" do
	  params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',:GEO_check =>'on', 
   	  :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_2 =>'on', :submit => "Search database"}
  	 
   	post :save_search, params
    expect(assigns(:result_datasets)).not_to eq(nil)
	end
	
	it "GEO searches based on Filters" do
	  params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',:GEO_check =>'on', 
   	  :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:submit => "Search database"}
  	 
   	post :save_search, params
    expect(assigns(:result_datasets)).not_to eq(nil)
	end
	
	it "GEO Redirects if it receives an invalid search by keyword " do
   	 
    params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => '', :GEO_check =>'on', 
    :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on',:submit => "Search database" }
   	 
    post :save_search, params
    expect(response).to redirect_to('/searchAll')
    flash[:warning].should eq("Invalid search! Please enter the search term")
    #expect(response.status).to eq(302)
  	end
  	
  	it "GEO Should query Geosearchresult for the stored results" do
  	 
   	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis', :GEO_check =>'on',
   	:GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on',:submit => "Search database" }
  	 
   	post :save_search, params
   	expect(assigns(:result_datasets)).not_to eq(nil)
  	 
	end
	
	it "GEO Should retrieve data from Geosearchresult model" do
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'prostate',:GEO_check => 'on',
      :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on', :submit => "Search database", :commit_save => 'save_back', :selected_keys_save_geo => 'GSE57885' ,:reasons_geo => ''}
      post :save_search,params
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'prostate',:GEO_check => 'on',
      :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on', :submit => "Search database"}
      post :save_search,params
      expect(assigns(:previous_results_geo)).not_to eq(nil)
	  end
      
    it "Should  save the search made by the user" do
    
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'prostate',:GEO_check => 'on',
      :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on', :submit => "Search database", :commit_save => 'save_back', :selected_keys_save_geo => 'GSE57885' ,:reasons_geo => 'howdy'}
    
    
    post :save_search, params
    
    flash[:warning].should eq("Curated results saved successfully!")
    end
    
    
    it "Should redirect if no database is selected for search" do
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :csearchBox => 'tuberculosis',
      :GEO_exp_1 =>'on', :GEO_exp_2 => 'on',:GEO_exp_3 =>'on',:GEO_exp_4 =>'on',:GEO_org_1 =>'on',:GEO_org_2 =>'on', :submit => "Search database"}
      
      post :save_search,params
      
      expect(response).to redirect_to('/searchAll')
    	flash[:warning].should eq("Invalid search! Please select a database")
    end
    
    
=begin
    	it "Should give no datatsets" do
	  params = {:attr => {:experSave => 'DNA assay', :techSave => 'Mass spectrometry assay'}, :searchSave => 'eye', :submit => "Search Array Express" }
	  
	  post :save_search,params
	  expect(assigns(:dataset_results)).to eq(nil)
	  expect(response).to redirect_to('/searchAll')
	   flash[:warning].should eq("No more dataset")
      end
=end	
 end
