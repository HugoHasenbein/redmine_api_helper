##
# aids creating fiddles for redmine_scripting_engine
#
# Copyright  2021 Stephan Wenzel <stephan.wenzel@drwpatent.de>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

module RedmineAPIHelper
  module APIHelper
  
  ########################################################################################
  # api functions
  ########################################################################################
  class TooManyRedirects < StandardError; end
  LIMIT_REDIRECTS = 10
  USER_AGENT      = ["Redmine API Helper", RedmineAPIHelper::VERSION].join(" ")
  
  ########################################################################################
  # returns error
  ########################################################################################
  def error(err)
    OpenStruct.new(:error => err.message, :backtrace => err.backtrace)
  end #def
  
  ########################################################################################
  # assembles url from fragments
  ########################################################################################
  def url_path(*fragments, **options)
    [fragments.map do |fragment|
       fragment.to_s.gsub(/\/\z/,"")
     end.join("/"),
     options.to_query.presence
    ].compact.join("?")
  end #def
  
  ########################################################################################
  # lists objects, corresponds to controller#index
  ########################################################################################
  def list_objects(objects, params={})
    jget(:url => send("#{objects}_url"), :params => params ).send(objects) 
  rescue Exception => err
    error(err)
  end #def
  
  def list_project_objects(project_id, objects, params={})
    jget(:url => send("project_#{objects}_url", project_id), :params => params ).send(objects)
  rescue Exception => err
    error(err)
  end #def
  
  ########################################################################################
  # reads object having id, corresponds to controller#show
  ########################################################################################
  def read_object(object, id, params={})
    jget(:url => send("#{object}_url", id), :params => params ).send(object)
  rescue Exception => err
    error(err)
  end #def
  
  def read_project_object(project_id, object, id, params={})
    jget(:url => send("project_#{object}_url", project_id, id), :params => params ).send(object)
  rescue Exception => err
    error(err)
  end #def
  
  ########################################################################################
  # creates a new object with params, corresponds to controller#create
  ########################################################################################
  def create_object(object, params={})
    jpost( {object => params}, :url => send("#{object.to_s.pluralize}_url") ).send(object)
  rescue Exception => err
    error(err)
  end #def
  
  def create_project_object(project_id, object, params={})
    jpost( {object => params}, :url => send("project_#{object.to_s.pluralize}_url", project_id) ).send(object)
  rescue Exception => err
    error(err)
  end #def
  
  ########################################################################################
  # updates an existing object with params, corresponds to controller#update
  ########################################################################################
  def update_object(object, id, params={})
    jput( {object  => params}, :url => send("#{object}_url", id) )
  rescue Exception => err
    error(err)
  end #def
  
  def update_project_object(project_id, object, id, params={})
    jput( {object  => params}, :url => send("project_#{object}_url", project_id, id) )
  rescue Exception => err
    error(err)
  end #def
  
  ########################################################################################
  # deletes an existing object with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_object(object, id, params={})
    jdel(:url => send("#{object}_url", id), :params => params )
  rescue Exception => err
    error(err)
  end #def
  
  def destroy_project_object(project_id, object, id, params={})
    jdel(:url => send("project_#{object}_url", project_id, id), :params => params )
  rescue Exception => err
    error(err)
  end #def
  
  ########################################################################################
  # fetch(options), get request
  ########################################################################################
  def fetch(options={})
    
    # create query parameters
    params                   = options[:params].to_h.to_query
    url                      = options[:url]
    
    # create GET request
    uri                      = URI.parse([url, params.presence].compact.join("?"))
    req                      = Net::HTTP::Get.new(uri.request_uri)
    
    # create HTTP handler
    http                     = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl             = uri.scheme.downcase == "https"
    
    # get request
    @http_response           = http.request(req)
    
    case @http_response
    
    when Net::HTTPSuccess 
      @http_response.body.present? ? @http_response.body : serialize(:response => "OK")
      
    when Net::HTTPRedirection 
      options[:redirects] = options[:redirects].to_i + 1
      raise TooManyRedirects if options[:redirects] > LIMIT_REDIRECTS
      fetch( options.merge(:url => response['location']) )
      
    else
      serialize(:response => @http_response.code)
      
    end
    
  end #def
  
  ########################################################################################
  # jget(options), get request
  ########################################################################################
  def jget(options={})
    
    index                    = options[:index].to_i
    json                     = options[:json].nil? || !!options[:json]
    params                   = json ? options[:params].to_h.merge(:format => "json").to_query : options[:params].to_h.to_query
    content_type             = json ? "application/json" : options[:content_type]
    api                      = options[:api_key].nil? ? true : !!options[:api_key]
    url                      = options[:url].presence || args.objects[index].object_url
    
    # create GET request
    uri                      = URI.parse( [url, params.presence].compact.join("?"))
    req                      = Net::HTTP::Get.new(uri.request_uri)
    req["Content-Type"]      = content_type
    req['X-Redmine-API-Key'] = args.api_key if api
    req["Referer"]           = args.deep_try(:eparams, :url) || args.deep_try(:urls, :back)
    req["User-Agent"]        = USER_AGENT
    req["Accept"]            = "*/*"
    req.basic_auth(args.site_user, args.site_password) if args.site_user.present? || args.site_password.present?
    
    # create HTTP handler
    http                     = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl             = uri.scheme.downcase == "https"
    
    # get request
    @http_response           = http.request(req)
    
    # follow redirection or get result code
    handle_response(options)
    
  end #def
  
  ########################################################################################
  # jput(body, options), put request
  ########################################################################################
  def jput(body, options={})
    
    index                    = options[:index].to_i
    json                     = options[:json].nil? || !!options[:json]
    params                   = json ? options[:params].to_h.merge(:format => "json").to_query : options[:params].to_h.to_query
    content_type             = json ? "application/json" : options[:content_type]
    api                      = options[:api_key].nil? ? true : !!options[:api_key]
    url                      = options[:url].presence || args.objects[index].object_url
    
    # create PUT request
    uri                      = URI.parse( [url, params.presence].compact.join("?"))
    req                      = Net::HTTP::Put.new(uri.request_uri)
    req["Content-Type"]      = content_type 
    req['X-Redmine-API-Key'] = args.api_key if api
    req["Referer"]           = args.deep_try(:eparams, :url) || args.deep_try(:urls, :back)
    req["User-Agent"]        = USER_AGENT
    req["Accept"]            = "*/*"
    req.basic_auth(args.site_user, args.site_password) if args.site_user.present? || args.site_password.present?
    
    # create body
    req.body                 = deserialize(body).to_json
    
    # create HTTP handler
    http                     = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl             = uri.scheme.downcase == "https"
    
    # get request
    @http_response           = http.request(req)
    
    # follow redirection or get result code
    handle_response(options)
    
  end #def
  
  ########################################################################################
  # jpost(body, options), post request
  ########################################################################################
  def jpost(body, options={})
    
    index                    = options[:index].to_i
    json                     = options[:json].nil? || !!options[:json]
    params                   = json ? options[:params].to_h.merge(:format => "json").to_query : options[:params].to_h.to_query
    content_type             = json ? "application/json" : options[:content_type]
    api                      = options[:api_key].nil? ? true : !!options[:api_key]
    url                      = options[:url].presence || args.objects[index].object_url
    
    # create POST request
    uri                      = URI.parse( [url, params.presence].compact.join("?"))
    req                      = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"]      = content_type 
    req['X-Redmine-API-Key'] = args.api_key if api
    req["Referer"]           = args.deep_try(:eparams, :url) || args.deep_try(:urls, :back)
    req["User-Agent"]        = USER_AGENT
    req["Accept"]            = "*/*"
    req.basic_auth(args.site_user, args.site_password) if args.site_user.present? || args.site_password.present?
    
    # create body
    req.body                 = deserialize(body).to_json
    
    # create HTTP handler
    http                     = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl             = uri.scheme.downcase == "https"
    
    # get request
    @http_response           = http.request(req)
    
    # follow redirection or get result code
    handle_response(options)
    
  end #def
  
  ########################################################################################
  # jdel(options), delete request
  ########################################################################################
  def jdel(options={})
    
    index                    = options[:index].to_i
    json                     = options[:json].nil? || !!options[:json]
    params                   = json ? options[:params].to_h.merge(:format => "json").to_query : options[:params].to_h.to_query
    content_type             = json ? "application/json" : options[:content_type]
    api                      = options[:api_key].nil? ? true : !!options[:api_key]
    url                      = options[:url].presence || args.objects[index].object_url
    
    # create DELETE request
    uri                      = URI.parse( [url, params.presence].compact.join("?"))
    req                      = Net::HTTP::Delete.new(uri.request_uri)
    req["Content-Type"]      = content_type
    req['X-Redmine-API-Key'] = args.api_key if api
    req["Referer"]           = args.deep_try(:eparams, :url) || args.deep_try(:urls, :back)
    req["User-Agent"]        = USER_AGENT
    req["Accept"]            = "*/*"
    req.basic_auth(args.site_user, args.site_password) if args.site_user.present? || args.site_password.present?
    
    # create HTTP handler
    http                     = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl             = uri.scheme.downcase == "https"
    
    # get request
    @http_response           = http.request(req)
    
    # follow redirection or get result code
    handle_response(options)
    
  end #def
  
  ########################################################################################
  # private
  ########################################################################################
  private
  
  ########################################################################################
  # handle_response
  ########################################################################################
  def handle_response(options)
  
    case @http_response
    
    when Net::HTTPSuccess
      @http_response.body.present? ? serialize(JSON.parse(@http_response.body)) : serialize(:result => @http_response.code)
      
    when Net::HTTPRedirection
      options[:redirects] = options[:redirects].to_i + 1
      raise TooManyRedirects if options[:redirects] > LIMIT_REDIRECTS
      function = caller_locations(1,1)[0].label.to_sym
      send(function, options)
      
    else
      @http_response.body.present? ? serialize(JSON.parse(@http_response.body)) : serialize(:result => @http_response.code)
      
    end
  end #def
  
  end #module
end #module