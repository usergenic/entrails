module Entrails::ActionController::TemplateForReferer
  
  private
  
  def default_template_name_with_template_for_referer
    template_name = default_template_name_without_template_for_referer
    begin
      @template.pick_template("#{template_name}_for_#{referer_named_route}")
    rescue
      template_name
    end
  end
  
  def referer_host
    URI.parse(request.referer).host unless request.referer.blank?
  end

  def referer_host_local?
    referer_host == request.host
  end
  
  def referer_named_route
    referer_params[:named_route]
  rescue
    nil
  end 

  def referer_params
    (ActionController::Routing::Routes.recognize_path(referer_path, :method => :get) if referer_host_local?) || {}
  rescue
    {}
  end

  def referer_path
    URI.parse(request.referer).path unless request.referer.blank?
  end
  
  def self.included(host)
    host.alias_method_chain :default_template_name, :template_for_referer
  end
  
end