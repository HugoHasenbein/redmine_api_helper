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
  module DefineAPIHelpers
  
  ########################################################################################
  # defines global standard helpers for object
  ########################################################################################
  def define_api_helpers(object)
  
    object  = object.to_s.singularize.to_sym
    objects = object.to_s.pluralize.to_sym
    
    # objects_url ########################################################################
    define_singleton_method("#{objects}_url".to_sym) do |**params|
      url_path(args.urls.Home, objects, params)
    end
    
    # project_objects_url ################################################################
    define_singleton_method("project_#{objects}_url".to_sym) do |project_id, **params|
      url_path(project_url(project_id), objects, params)
    end
    
    # object_url #########################################################################
    define_singleton_method("#{object}_url".to_sym) do |id, **params|
      url_path(send("#{objects}_url".to_sym), id, params)
    end
    
    # project_object_url #################################################################
    define_singleton_method("project_#{object}_url".to_sym) do |project_id, id, **params|
      url_path(send("project_#{objects}_url".to_sym, project_id), id, params)
    end
    
    # list_objects #######################################################################
    define_singleton_method("list_#{objects}".to_sym) do |**params|
      list_objects(objects, params)
    end
    
    # list_project_objects ###############################################################
    define_singleton_method("list_project_#{objects}".to_sym) do |project_id, **params|
      list_project_objects(project_id, objects, params)
    end
    
    # create_object ######################################################################
    define_singleton_method("create_#{object}".to_sym) do |**params|
      create_object(object, params)
    end
    
    # read_object ########################################################################
    # update_object ######################################################################
    # destroy_object #####################################################################
    %w(read update destroy).each do |action|
      define_singleton_method("#{action}_#{object}".to_sym) do |id, **params|
        send("#{action}_object".to_sym, object, id, params)
      end
    end
    
  end #def
  
  end #module
end #module
