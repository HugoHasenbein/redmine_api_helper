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
  module NewsAPIHelper
  
  ########################################################################################
  # reads news_url from args
  ########################################################################################
  def news_index_url
    args.urls.News
  end #def
  
  ########################################################################################
  # creates new_url
  ########################################################################################
  def news_url(id)
    [news_index_url, id].join("/")
  end #def
  
  ########################################################################################
  # reads project_news_url from args
  ########################################################################################
  def project_news_index_url(project_id)
    [args.urls.Project, project_id, "news"].join("/")
  end #def
  
  ########################################################################################
  # creates project_new_url 
  ########################################################################################
  def project_news_url(project_id, id)
    [project_news_index_url(project_id), id].join("/")
  end #def
  
  ########################################################################################
  # list_news result, corresponds to controller#index
  ########################################################################################
  def list_news(params={})
    list_objects(:news, params)
  end #def
  
  ########################################################################################
  # list_news result, corresponds to controller#index
  ########################################################################################
  def list_project_news(project_id, params={})
    list_project_objects(project_id, :news, params)
  end #def
  
  ########################################################################################
  # list_news result, corresponds to controller#index
  ########################################################################################
  def read_news(params={})
    read_object(:news, params)
  end #def
  
  end #module
end #module
