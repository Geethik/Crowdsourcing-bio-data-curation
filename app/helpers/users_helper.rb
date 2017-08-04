module UsersHelper
    require 'yaml'
    require 'net/http'
    require 'json'
    require 'nokogiri'
    require 'open-uri'
  
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
        if !value["accession"].include?("GEOD")
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
            gse_id=''
            if !value["secondaryaccession"].nil?
                gse_id = value["secondaryaccession"][0]
            end
            data_result[value["accession"]]=[gse_id,value["name"],exper_type,exper_org,value["releasedate"],exper_assays,"unchecked",""]
        end
    }

    # Use this for debug

    #    data_result=Hash.new
    #    data_result["E-GEOD-57691"]="Differential gene expression in human abdominal aortic aneurysm and atherosclerosis"
    #    data_result["E-MTAB-3175"]="Gene expression study in Positron Emission Tomography (PET) positive abdominal aortic aneurysms"
    return data_result
  end    
    
def search_data_GEO(keyword,f1,f2,f3,f4,f5,f6)
        s1=""
        s2=""
        s3=""
        s4=""
        s5=""
        s6=""
      if f1=="on"
        s1 = "Expression profiling by array"
      end
      if f2=="on"
        s2 = "Expression profiling by high throughput sequencing"
      end
      if f3=="on"
        s3 = "Non-coding RNA profiling by array"
      end
      if f4=="on"
        s4 = "Non-coding RNA profiling by high throughput sequencing"
      end
      if f5=="on"
        s5 = "Homo sapiens"
      end
      if f6=="on"
        s6 = "Mouse"
      end
      
      datasets = {}
      if s5!="" and s6!=""
        url_1 = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=gds&term="+keyword+" AND (\""+s5+"\"[Organism] OR \""+s6+"\"[Organism] AND (\""+s1+
            "\"[Filter] OR \""+s2+"\"[Filter] OR \""+s3+"\"[Filter] OR \""+s4+"\"[Filter]))&retmax=1000";
      elsif s5!=""
        url_1 = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=gds&term="+keyword+" AND (\""+s5+"\"[Organism] AND (\""+s1+
            "\"[Filter] OR \""+s2+"\"[Filter] OR \""+s3+"\"[Filter] OR \""+s4+"\"[Filter]))&retmax=1000";
      elsif s6!=""
        url_1 = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=gds&term="+keyword+" AND (\""+s6+"\"[Organism] AND (\""+s1+
            "\"[Filter] OR \""+s2+"\"[Filter] OR \""+s3+"\"[Filter] OR \""+s4+"\"[Filter]))&retmax=1000";
      else
        url_1 = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=gds&term="+keyword+" AND (\""+s1+
            "\"[Filter] OR \""+s2+"\"[Filter] OR \""+s3+"\"[Filter] OR \""+s4+"\"[Filter])&retmax=1000";  
      end
      p url_1
      doc = Nokogiri::XML(open(url_1))
      all_ids = Array.new
      dataset_ids = Array.new
    
      doc.xpath('//Id').each do |id|
          all_ids << id
      end

      all_ids.each_slice(100) do |slice|
          batch_of_ids = Array.new
        slice.each do |id_1|
            batch_of_ids << id_1
            end
        
          collection_ids = batch_of_ids.join(",")
          collection_ids = collection_ids.to_s
     
      url_2 = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=gds&id="+collection_ids
      doc_datasets = Nokogiri::XML(open(url_2))
      
      doc_datasets.xpath('//DocSum').each do |dataset_summary|
          accession_number = dataset_summary.xpath('Id').text
          accession_GSE_ID = dataset_summary.xpath("Item[@Name='GSE']").text
          accession_title = dataset_summary.xpath("Item[@Name='title']").text
          accession_organism = dataset_summary.xpath("Item[@Name='taxon']").text
          accession_release_date = dataset_summary.xpath("Item[@Name='PDAT']").text
          accession_nsamples = dataset_summary.xpath("Item[@Name='n_samples']").text
          #accession_summary = dataset_summary.xpath("//*[contains(local-name(), 'summary')]")
          datasets[accession_number] = ["GSE"+accession_GSE_ID,accession_title,accession_organism,accession_release_date,accession_nsamples,"unchecked",""]
        end
        
      end

    return datasets
  end

end
