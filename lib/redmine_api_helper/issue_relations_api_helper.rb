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
  module IssueRelationsAPIHelper
  
  ########################################################################################
  # reads issue_relations_url from args
  ########################################################################################
  def issue_relations_url(issue_id, **params)
    url_path(issue_url(issue_id), "relations", params)
  end #def
  
  ########################################################################################
  # reads relations_url from args
  ########################################################################################
  def relation_url(id, **params)
    url_path(args.urls.Home, "relations", id, params)
  end #def
  
  ########################################################################################
  # lists issue_relations, corresponds to controller#index
  ########################################################################################
  def list_issue_relations(issue_id, **params)
    jget(:url => issue_relations_url(issue_id), :params => params).relations
  end #def
  
  ########################################################################################
  # reads issue having id, corresponds to controller#show
  ########################################################################################
  def read_relation(id, **params)
    jget(:url => relation_url(id), :params => params).relation
  end #def
  
  ########################################################################################
  # creates a new issue with params, corresponds to controller#create
  ########################################################################################
  def create_issue_relation(issue_id, **params)
    jpost(params, :url => issue_relations_url(issue_id)).relation
  end #def
  
  ########################################################################################
  # deletes an existing issue with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_relation(id, **params)
    jdel(:url => relation_url(id), :params => params)
  end #def
  
  end #module
end #module
