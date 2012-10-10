class ApisController < ApplicationController
  def tracker
  	respond_to do |format|
    	format.png {  

        genuine_current_path = request.env['HTTP_REFERER']
        genuine_domain_url = "http://" + URI.parse(genuine_current_path).host
        passed_domain_url = request.filtered_parameters['domain_url']
        visit_path = request.filtered_parameters['current_path']
        reference_path = request.filtered_parameters['referrer_path'].blank? ? "" : (("http://" + URI.parse(request.filtered_parameters['referrer_path']).host == genuine_domain_url) ? URI.parse(request.filtered_parameters['referrer_path']).request_uri : "")
        visitor_ip = request.env['REMOTE_ADDR']

        logger.info("\nRequest URL: "+genuine_current_path+"\n")
        logger.info("\nRequest URL HOST: "+genuine_domain_url+"\n")
        logger.info("\nProject Domain URL => URL:\n" + passed_domain_url + "\n")
        logger.info("\nCurrent (Visit) Path => URL:\n" + visit_path + "\n")
        logger.info("\nReferrer Path => URL:\n" +reference_path+ "\n")
        logger.info("\nReferrer Path (is nil?) => :\n" + reference_path.nil?.to_s + " ---- Length => " + reference_path.length.to_s + " \n")
        logger.info("\nHTTP HEADER => VISITOR IP:\n" +visitor_ip+ "\n")

        if genuine_domain_url == passed_domain_url 
          if project = Project.find_by_domain_url(genuine_domain_url)
            project.analytic_datas.create(:ip_address => visitor_ip, :visit_path => visit_path, :reference_path => reference_path)
          end
        end
        render :nothing => true
    	}
    end
  end
end