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
  module TimeEntryActivitiesAPIHelper
  
  ########################################################################################
  # reads time_entry_activities_url from args
  ########################################################################################
  def time_entry_activities_url(**params)
    url_path(args.urls.Home, "enumerations", "time_entry_activities", params)
  end #def
  
  ########################################################################################
  # lists time_entries, corresponds to controller#index
  ########################################################################################
  def list_time_entry_activities(**params)
    list_objects(:time_entry_activities, params)
  end #def
  
  end #module
end #module
