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
  module IssuesAPIHelper
  
  ########################################################################################
  # reads issues_url from args
  ########################################################################################
  def issues_url
    args.urls.Issue
  end #def
  
  ########################################################################################
  # creates issue_url
  ########################################################################################
  def issue_url(id)
    [issues_url, id].join("/")
  end #def
  
  ########################################################################################
  # reads issues_url from args
  ########################################################################################
  def project_issues_url(project_id)
    [project_url(project_id), 'issues'].join("/")
  end #def
  
  ########################################################################################
  # creates project_issue_url
  ########################################################################################
  def project_issue_url(project_id, id)
    [project_issues_url(project_id), id].join("/")
  end #def
  
  ########################################################################################
  # lists issues, corresponds to controller#index
  ########################################################################################
  def list_issues(params={})
    list_objects(:issues, params)
  end #def
  
  ########################################################################################
  # lists project issues, corresponds to controller#index
  ########################################################################################
  def list_project_issues(project_id, params={})
    list_project_objects(project_id, :issues, params)
  end #def
  
  ########################################################################################
  # reads issue having id, corresponds to controller#show
  ########################################################################################
  def read_issue(id, params={})
    read_object(:issue, id, params)
  end #def
  
  ########################################################################################
  # creates a new issue with params, corresponds to controller#create
  ########################################################################################
  def create_issue(params={})
    create_object(:issue, params)
  end #def
  
  ########################################################################################
  # updates an existing issue with params, corresponds to controller#update
  ########################################################################################
  def update_issue(id, params={})
    update_object(:issue, id, params)
  end #def
  
  ########################################################################################
  # 'bulk_updates' existing issues with params, simulate controller#bulk_update
  ########################################################################################
  def update_issues(ids, params={})
    ids.each do |id|
      update_object(:issue, id, params)
    end
  end #def
  
  ########################################################################################
  # deletes an existing issue with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_issue(id, params={})
    destroy_object(:issue, id, params)
  end #def
  
  ########################################################################################
  # reads watchers_url from args
  ########################################################################################
  def watchers_url
    args.urls.Watch
  end #def
  
  ########################################################################################
  # creates a watcher with params, corresponds to watchers#create: params: user_id
  ########################################################################################
  def create_issue_watcher(issue_id, user_id, params={})
    jpost(params.merge(:object_type => 'issue', :object_id => issue_id, :user_id => user_id), :url => watchers_url )
  end #def
  
  ########################################################################################
  # deletes a watcher with params, corresponds to watchers#destroy
  ########################################################################################
  def destroy_issue_watcher(issue_id, user_id, params={})
    jdel(:url => watchers_url, :params => params.merge(:object_type => 'issue', :object_id => issue_id, :user_id => user_id))
  end #def
  
  end #module
end #module
