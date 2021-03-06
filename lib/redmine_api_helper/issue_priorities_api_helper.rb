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
  module IssuePrioritiesAPIHelper
  
  ########################################################################################
  # reads issue_priorities_url from args
  ########################################################################################
  def issue_priorities_url(**params)
    url_path(args.urls.Home, "enumerations", "issue_priorities", params)
  end #def
  
  ########################################################################################
  # lists issue_priorities, corresponds to controller#index
  ########################################################################################
  def list_issue_priorities(**params)
    list_objects(:issue_priorities, params)
  end #def
  
  end #module
end #module
