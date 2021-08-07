# encoding: utf-8
#
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
  module Helpers
  
    include RedmineAPIHelper::APIHelper
    include RedmineAPIHelper::ArgsHelper
    include RedmineAPIHelper::DefineAPIHelpers
    
    include RedmineAPIHelper::AttachmentsAPIHelper
    include RedmineAPIHelper::DocumentCategoriesAPIHelper
    include RedmineAPIHelper::GroupsAPIHelper
    include RedmineAPIHelper::IssuePrioritiesAPIHelper
    include RedmineAPIHelper::IssueRelationsAPIHelper
    include RedmineAPIHelper::IssueStatusesAPIHelper
    include RedmineAPIHelper::IssuesAPIHelper
    include RedmineAPIHelper::MyAccountAPIHelper
    include RedmineAPIHelper::NewsAPIHelper
    include RedmineAPIHelper::ProjectMembershipsAPIHelper
    include RedmineAPIHelper::ProjectsAPIHelper
    include RedmineAPIHelper::RolesAPIHelper
    include RedmineAPIHelper::SearchAPIHelper
    include RedmineAPIHelper::TimeEntriesAPIHelper
    include RedmineAPIHelper::TimeEntryActivitiesAPIHelper
    include RedmineAPIHelper::TrackersAPIHelper
    include RedmineAPIHelper::UsersAPIHelper
    include RedmineAPIHelper::WikiPagesAPIHelper
    include RedmineAPIHelper::ScriptsAPIHelper
    
  end
end 