require 'rails_helper'

describe UsersController do
    
	it "Renders the searchAll template" do
   	params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :searchSave => 'tuberculosis', :submit => "Search Array Express"}
  	 
   	post :save_search, params
   	expect(response).to render_template('searchAll')
	end
    
	it "Receives the relevant filters from params" do
   	 
    	params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :searchSave => 'tuberculosis', :submit => "Search Array Express"}
   	 
    	post :save_search, params
    	expect(assigns(:attr_exper)).to eq('RNA assay')
    	expect(assigns(:attr_tech)).to eq('Sequencing assay')
	end
    
	it "Redirects if it receives an invalid search " do
   	 
    	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave => '', :submit => "Search Array Express" }
   	 
    	post :save_search, params
    	expect(response.status).to eq(302)
  	end
    
	it "Should query Partsearchresult for the stored results" do
  	 
   	params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :searchSave => 'tuberculosis', :submit => "Search Array Express" }
  	 
   	post :save_search, params
   	expect(assigns(:users)).not_to eq(nil)
  	 
	end
	
	it "Should give no datatsets" do
	  params = {:attr => {:experSave => 'DNA assay', :techSave => 'Mass spectrometry assay'}, :searchSave => 'eye', :submit => "Search Array Express" }
	  
	  post :save_search,params
	  expect(assigns(:dataset_results)).to eq(nil)
	  expect(response).to redirect_to('/searchAll')
	   flash[:warning].should eq("No more dataset")
      end
      
  	it "Should retrieve data from Savesearchresult model" do
      params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :searchSave => 'tuberculosis', :submit => "Search Array Express", :commit_save => 'save_back', :selected_keys_save => 'E-GEOD-77556' ,:reasons => ''}
      post :save_search,params
      params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :searchSave => 'tuberculosis', :submit => "Search Array Express"}
      post :save_search,params
      expect(assigns(:previous_results)).not_to eq(nil)
	  end
      
    it "Should  save the search made by the user" do
    
    params = {:attr => {:experSave => 'RNA assay', :techSave => 'Sequencing assay'}, :searchSave => 'tuberculosis', :submit => "Search Array Express", :commit_save => 'save_back', :selected_keys_save => 'E-GEOD-77556' ,:reasons => ''}
    
    
    post :save_search, params
    
    flash[:warning].should eq("Curated results saved successfully!")
    end
    
    it "GEO Renders the searchAll template" do
   	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave_geo => 'tuberculosis', :submit => "Search GEO"}
  	 
   	post :save_search, params
   	expect(response).to render_template('searchAll')
	end
	
	it "GEO Redirects if it receives an invalid search " do
   	 
    params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave_geo => '', :submit => "Search GEO" }
   	 
    post :save_search, params
    expect(response.status).to eq(302)
  	end
  	
  	it "GEO Should query Partsearchresult for the stored results" do
  	 
   	params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave_geo => 'tuberculosis', :submit => "Search GEO" }
  	 
   	post :save_search, params
   	expect(assigns(:result_datasets)).not_to eq(nil)
  	 
	end
	
	it "GEO Should retrieve data from Savesearchresult model" do
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave_geo => 'tuberculosis', :submit => "Search GEO", :commit_save_GEO => 'save_back', :selected_keys_save => 'GSE65517' ,:reasons => ''}
      post :save_search,params
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave_geo => 'tuberculosis', :submit => "Search GEO"}
      post :save_search,params
      expect(assigns(:previous_results_geo)).not_to eq(nil)
	  end
      
    it "Should  save the search made by the user" do
    
      params = {:attr => {:experSave => 'All assays by Molecule', :techSave => 'All technologies'}, :searchSave_geo => 'tuberculosis', :submit => "Search GEO", :commit_save_GEO => 'save_back', :selected_keys_save => 'GSE65517' ,:reasons => 'howdy'}
    
    
    post :save_search, params
    
    flash[:warning].should eq("Curated results saved successfully!")
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
