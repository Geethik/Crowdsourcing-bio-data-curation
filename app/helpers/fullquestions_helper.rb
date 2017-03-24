module FullquestionsHelper

  require 'yaml'
  require 'net/http'
  require 'json'
  
  def search_from_arrayexpress(keywords)
# Use this for formal version

    url = 'https://www.ebi.ac.uk/arrayexpress/xml/v3/experiments?keywords='+keywords;
#   p url
=begin
    #uri = URI(url)
    #response = Net::HTTP.get(uri)
    #data_hash=JSON.parse(response)
    #debugger
    #if(data_hash["experiments"]["total"] == 0)
    #    return nil
    #end
    #data_result=Hash.new
    #data_hash["experiments"]["experiment"].each do |value|
    #    if i>20
    #        break
    #    end
    #    data_result[value["accession"]]=value["name"]
    #    i=i+1
   # end
=end   
    data_doc = Nokogiri::XML(Net::HTTP.get(URI(url)))
    counter = data_doc.at('//experiments/@total').value()
    counter =counter.to_i
    #debugger
    if(counter==0)
        return nil
    end
    
   
    
    data_result=Hash.new
    
    dat_accession = data_doc.xpath('//experiment/accession')
    dat_name = data_doc.xpath('//experiment/name')
    if counter>20
        (1..20).each do |acc|
            data_result[dat_accession[acc].text()] = dat_name[acc].text()
        end
    else
        1.upto(counter).each do |acc|
            data_result[dat_accession[acc].text()] = dat_name[acc].text()
        end
    end
    
   
    

# Use this for debug

#    data_result=Hash.new
#    data_result["E-GEOD-57691"]="Differential gene expression in human abdominal aortic aneurysm and atherosclerosis"
#    data_result["E-MTAB-3175"]="Gene expression study in Positron Emission Tomography (PET) positive abdominal aortic aneurysms"
    return data_result
  end    
    
    
    
    
end