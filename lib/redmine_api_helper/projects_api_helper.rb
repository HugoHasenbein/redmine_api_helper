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
  module ProjectsAPIHelper
  
  ########################################################################################
  # reads projects_url from args
  ########################################################################################
  def projects_url(**params)
    url_path(args.urls.Home, "projects", params)
  end #def
  
  ########################################################################################
  # creates project_url
  ########################################################################################
  def project_url(id, **params)
    url_path(projects_url, id, params)
  end #def
  
  ########################################################################################
  # lists projects, corresponds to controller#index
  ########################################################################################
  def list_projects(**params)
    list_objects(:projects, params)
  end #def
  
  ########################################################################################
  # reads project having id, corresponds to controller#show
  ########################################################################################
  def read_project(id, **params)
    read_object(:project, id, params)
  end #def
  
  ########################################################################################
  # creates a new project with params, corresponds to controller#create
  ########################################################################################
  def create_project(**params)
    create_object(:project, params)
  end #def
  
  ########################################################################################
  # updates an existing project with params, corresponds to controller#update
  ########################################################################################
  def update_project(id, **params)
    update_object(:project, id, params)
  end #def
  
  ########################################################################################
  # deletes an existing project with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_project(id, **params)
    destroy_object(:project, id, params)
  end #def
  
  end #module
end #module
