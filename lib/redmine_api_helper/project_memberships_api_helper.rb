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
  module ProjectMembershipsAPIHelper
  
  ########################################################################################
  # reads projects_url from args
  ########################################################################################
  def project_memberships_url(project_id, **params)
    url_path(project_url(project_id), "memberships", params)
  end #def
  
  def memberships_url(**params)
    url_path(args.urls.Home, "memberships", params)
  end #def
  
  ########################################################################################
  # creates a membership_url
  ########################################################################################
  def membership_url(id, **params)
    url_path(memberships_url, id, params)
  end #def
  
  ########################################################################################
  # lists projects, corresponds to controller#index
  ########################################################################################
  def list_project_memberships(project_id, **params)
    list_project_objects(project_id, :memberships, params)
  end #def
  
  ########################################################################################
  # reads project having id, corresponds to controller#show
  ########################################################################################
  def read_membership(id, **params)
    read_object(:membership, id, params)
  end #def
  
  ########################################################################################
  # creates a new project with params, corresponds to controller#create
  ########################################################################################
  def create_project_membership(project_id, **params)
    create_project_object(project_id, :membership, params)
  end #def
  
  ########################################################################################
  # updates an existing project with params, corresponds to controller#update
  ########################################################################################
  def update_membership(id, **params)
    update_object(:membership, id, params)
  end #def
  
  ########################################################################################
  # deletes an existing project with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_membership(id, **params)
    destroy_object(:membership, id, params)
  end #def
  
  end #module
end #module
