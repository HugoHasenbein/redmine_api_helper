##
# aids creating fiddles for redmine_scripting_engine
#
# Copyright © 2021 Stephan Wenzel <stephan.wenzel@drwpatent.de>
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
  module WikiPagesAPIHelper
  
  ########################################################################################
  # reads wiki_pages_url from args
  ########################################################################################
  def project_wiki_pages_url(project_id)
    [args.urls.Project, project_id, "wiki"].join("/")
  end #def
  
  ########################################################################################
  # creates wiki_page_url 
  ########################################################################################
  def project_wiki_page_url(project_id, id)
    [project_wiki_pages_url(project_id), id].join("/")
  end #def

  ########################################################################################
  # lists wiki_pages, corresponds to controller#index
  ########################################################################################
  def list_project_wiki_pages(project_id, params={})
    jget(:url => [project_wiki_pages_url(project_id), "index"].join("/"), :params => params )
  end #def
  
  ########################################################################################
  # reads wiki_page having id, corresponds to controller#show
  ########################################################################################
  def read_project_wiki_page(project_id, title, params={})
    jget(:url => [project_wiki_pages_url(project_id), title].join("/"), :params => params ).wiki_page
  end #def
  
  ########################################################################################
  # updates or creates an existing wiki_page with params, corresponds to controller#update
  ########################################################################################
  def create_or_update_project_wiki_page(project_id, title, params={})
    jput({:wiki_page => params}, :url => [project_wiki_pages_url(project_id), title].join("/"))
  end #def
  
  ########################################################################################
  # deletes an existing wiki_page with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_project_wiki_page(project_id, id, params={})
    jdel(:url => [project_wiki_pages_url(project_id), id].join("/"), :params => params )
  end #def
  
  end #module
end #module