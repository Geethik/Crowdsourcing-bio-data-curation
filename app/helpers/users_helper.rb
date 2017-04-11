module UsersHelper
    require 'yaml'
    require 'net/http'
    require 'json'
  
  def search_data_arrayexpress(keywords,filt_exper,filt_tech)
    # Use this for formal version
    if (filt_exper!='' and filt_tech!='')
        url = "https://www.ebi.ac.uk/arrayexpress/json/v3/experiments?keywords=\""+keywords+"\"&exptype=\""+filt_exper+"\"&exptype=\""+filt_tech+"\"";
    elsif (filt_exper!='')
        url = "https://www.ebi.ac.uk/arrayexpress/json/v3/experiments?keywords=\""+keywords+"\"&exptype=\""+filt_exper+"\"";
    elsif (filt_tech!='')
        url = "https://www.ebi.ac.uk/arrayexpress/json/v3/experiments?keywords=\""+keywords+"\"&exptype=&exptype=\""+filt_tech+"\""
    else
        url = "https://www.ebi.ac.uk/arrayexpress/json/v3/experiments?keywords=\""+keywords+"\"";
    end
       
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data_hash=JSON.parse(response)
    #debugger
    if(data_hash["experiments"]["total"] == 0)
        return nil
    end
    
    data_result=Hash.new
    data_hash["experiments"]["experiment"].each {|value|
        
        if !value["bioassaydatagroup"].nil?
            #if !value["bioassaydatagroup"]["bioassays"].nil?
                exper_assays =  value["bioassaydatagroup"][0]["bioassays"]
            #end
        end
        
        if !value["experimenttype"].nil?
            exper_type = value["experimenttype"][0]
        end
        
        if !value["organism"].nil?
            exper_org = value["organism"][0]
        end
        data_result[value["accession"]]=[value["name"],exper_type,exper_org,value["releasedate"],exper_assays,"unchecked",""]
    }

    # Use this for debug

    #    data_result=Hash.new
    #    data_result["E-GEOD-57691"]="Differential gene expression in human abdominal aortic aneurysm and atherosclerosis"
    #    data_result["E-MTAB-3175"]="Gene expression study in Positron Emission Tomography (PET) positive abdominal aortic aneurysms"
    return data_result
  end    
    
end
