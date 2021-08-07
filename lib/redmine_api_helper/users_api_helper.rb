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
  module UsersAPIHelper
  
  ########################################################################################
  # reads users_url from args
  ########################################################################################
  def users_url(**params)
    url_path(args.urls.Home, "users", params)
  end #def
  
  ########################################################################################
  # crerate user_url
  ########################################################################################
  def user_url(id, **params)
    url_path(users_url, id, **params)
  end #def
  
  ########################################################################################
  # lists users, corresponds to controller#index
  ########################################################################################
  def list_users(**params)
    list_objects(:users, params)
  end #def
  
  ########################################################################################
  # reads user having id, corresponds to controller#show
  ########################################################################################
  def read_user(id, **params)
    read_object(:user, id, params)
  end #def
  
  ########################################################################################
  # creates a new user with params, corresponds to controller#create
  ########################################################################################
  def create_user(**params)
    create_object(:user, params)
  end #def
  
  ########################################################################################
  # updates an existing user with params, corresponds to controller#update
  ########################################################################################
  def update_user(id, **params)
    update_object(:user, id, params)
  end #def
  
  ########################################################################################
  # deletes an existing user with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_user(id, **params)
    destroy_object(:user, id, params)
  end #def
  
  end #module
end #module
