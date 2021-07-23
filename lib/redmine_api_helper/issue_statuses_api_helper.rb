##
# aids creating fiddles for redmine_scripting_engine
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
  module IssueStatusesAPIHelper
  
  ########################################################################################
  # reads issue_statuses_url from args
  ########################################################################################
  def issue_statuses_url
    args.urls.IssueStatus
  end #def
  
  ########################################################################################
  # lists issue_statuses, corresponds to controller#index
  ########################################################################################
  def list_issue_statuses(params={})
    list_objects(:issue_statuses, params)
  end #def
  
  end #module
end #module
