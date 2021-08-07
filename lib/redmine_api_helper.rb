# encoding: utf-8
#
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

require "redmine_api_helper/version"
require "redmine_api_helper/api_helper"
require "redmine_api_helper/args_helper"
require "redmine_api_helper/define_api_helpers"

require "redmine_api_helper/attachments_api_helper"
require "redmine_api_helper/document_categories_api_helper"
require "redmine_api_helper/groups_api_helper"
require "redmine_api_helper/issue_priorities_api_helper"
require "redmine_api_helper/issue_relations_api_helper"
require "redmine_api_helper/issue_statuses_api_helper"
require "redmine_api_helper/issues_api_helper"
require "redmine_api_helper/my_account_api_helper"
require "redmine_api_helper/news_api_helper"
require "redmine_api_helper/project_memberships_api_helper"
require "redmine_api_helper/projects_api_helper"
require "redmine_api_helper/roles_api_helper"
require "redmine_api_helper/scripts_api_helper"
require "redmine_api_helper/search_api_helper"
require "redmine_api_helper/time_entries_api_helper"
require "redmine_api_helper/time_entry_activities_api_helper"
require "redmine_api_helper/trackers_api_helper"
require "redmine_api_helper/users_api_helper"
require "redmine_api_helper/wiki_pages_api_helper"

require "redmine_api_helper/helpers"

# goodies ODF writer

require 'zip'
require 'fileutils'
require 'nokogiri'

require 'redmine_api_helper/odf_writer/parser/default'
require 'redmine_api_helper/odf_writer/path_finder'
require 'redmine_api_helper/odf_writer/nested'
require 'redmine_api_helper/odf_writer/field'
require 'redmine_api_helper/odf_writer/field_reader'
require 'redmine_api_helper/odf_writer/text'
require 'redmine_api_helper/odf_writer/text_reader'
require 'redmine_api_helper/odf_writer/bookmark'
require 'redmine_api_helper/odf_writer/bookmark_reader'
require 'redmine_api_helper/odf_writer/image'
require 'redmine_api_helper/odf_writer/image_reader'
require 'redmine_api_helper/odf_writer/table'
require 'redmine_api_helper/odf_writer/table_reader'
require 'redmine_api_helper/odf_writer/section'
require 'redmine_api_helper/odf_writer/section_reader'
require 'redmine_api_helper/odf_writer/images'
require 'redmine_api_helper/odf_writer/template'
require 'redmine_api_helper/odf_writer/document'
require 'redmine_api_helper/odf_writer/style'
require 'redmine_api_helper/odf_writer/list_style'

require 'redmine_api_helper/odf_writer/odf_helper'

