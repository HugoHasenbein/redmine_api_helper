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
  module GroupsAPIHelper
  
  ########################################################################################
  # reads groups_url from args
  ########################################################################################
  def groups_url
    args.urls.Group
  end #def
  
  ########################################################################################
  # creates group_url 
  ########################################################################################
  def group_url(id)
    [groups_url, id].join("/")
  end #def
  
  ########################################################################################
  # lists groups, corresponds to controller#index
  ########################################################################################
  def list_groups(params={})
    list_objects(:group, params)
  end #def
  
  ########################################################################################
  # reads group having id, corresponds to controller#show
  ########################################################################################
  def read_group(id, params={})
    read_object(:group, id, params)
  end #def
  
  ########################################################################################
  # creates a new group with params, corresponds to controller#create
  ########################################################################################
  def create_group(params={})
    create_object(:group, params)
  end #def
  
  ########################################################################################
  # updates an existing group with params, corresponds to controller#update
  ########################################################################################
  def update_group(id, params={})
    update_object(:group, id, params)
  end #def
  
  ########################################################################################
  # updates an existing group with params, corresponds to controller#update
  ########################################################################################
  def group_add_user(id, user_id, params={})
    jpost(params.merge(:user_id => user_id), :url => [groups_url, id, "users"].join("/"))
  end #def
  
  ########################################################################################
  # deletes an existing group with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_group(id, params={})
    destroy_object(:group, id, params)
  end #def
  
  end #module
end #module