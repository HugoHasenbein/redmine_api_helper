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
  module ScriptsAPIHelper
  
  ########################################################################################
  # reads scripts_url from args
  ########################################################################################
  def scripts_url(**params)
    url_path(args.urls.Home, 'scripts', params)
  end #def
  
  ########################################################################################
  # reads project_scripts_url from args
  ########################################################################################
  def project_scripts_url(project_id, **params)
    url_path(project_url(project_id), 'scripts', params)
  end #def
  
  ########################################################################################
  # reads run_script_url from args
  ########################################################################################
  def run_script_url(id, **params)
    url_path(scripts_url, id, 'run', params)
  end #def
  
  ########################################################################################
  # reads run_project_script_url from args
  ########################################################################################
  def run_project_script_url(project_id, id, **params)
    url_path(project_scripts_url(project_id), id, 'run', params)
  end #def
  
  ########################################################################################
  # lists scripts, corresponds to controller#index
  ########################################################################################
  def list_scripts(project_id, **params)
    list_objects(:scripts, params)
  end #def
  
  ########################################################################################
  # lists scripts, corresponds to controller#index
  ########################################################################################
  def list_project_scripts(project_id, **params)
    list_project_objects(project_id, :scripts, params)
  end #def
  
  ########################################################################################
  # reads script having id, corresponds to controller#show
  ########################################################################################
  def read_script(id, **params)
    read_object(:script, id, params)
  end #def
  
  ########################################################################################
  # runs script having id, corresponds to controller#run
  ########################################################################################
  def run_script(id, **params)
    jget(:url => run_script_url(id), :params => params ).script
  end #def
  
  ########################################################################################
  # runs script having id, corresponds to controller#run
  ########################################################################################
  def run_project_script(project_id, id, **params)
    jget(:url => run_project_script_url(project_id, id), :params => params ).script
  end #def
  
  end #module
end #module
