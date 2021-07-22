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
  module TimeEntriesAPIHelper
  
  ########################################################################################
  # reads time_entries_url from args
  ########################################################################################
  def time_entries_url
    args.urls.TimeEntry
  end #def
  
  ########################################################################################
  # lists time_entries, corresponds to controller#index
  ########################################################################################
  def list_time_entries(params={})
    list_objects(:time_entry, params)
  end #def
  
  ########################################################################################
  # reads time_entry having id, corresponds to controller#show
  ########################################################################################
  def read_time_entry(id, params={})
    read_object(:time_entry, id, params)
  end #def
  
  ########################################################################################
  # creates a new time_entry with params, corresponds to controller#create
  ########################################################################################
  def create_time_entry(params={})
    create_object(:time_entry, params)
  end #def
  
  ########################################################################################
  # updates an existing time_entry with params, corresponds to controller#update
  ########################################################################################
  def update_time_entry(id, params={})
    update_object(:time_entry, id, params)
  end #def
  
  ########################################################################################
  # deletes an existing time_entry with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_time_entry(id, params={})
    destroy_object(:time_entry, id, params)
  end #def
  
  end #module
end #module
