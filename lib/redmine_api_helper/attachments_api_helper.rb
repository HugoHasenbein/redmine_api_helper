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
  module AttachmentsAPIHelper
  
  ########################################################################################
  # reads attachments_url from args
  ########################################################################################
  def attachments_url
    args.urls.Attachment
  end #def
  
  ########################################################################################
  # reads attachment having id, corresponds to controller#show
  ########################################################################################
  def read_attachment(id, params={})
    read_object(:attachment, id, params)
  end #def
  
  ########################################################################################
  # updates an existing attachment with params, corresponds to controller#update
  ########################################################################################
  def update_attachment(id, params={})
    update_object(:attachment, id, params)
  end #def
  
  ########################################################################################
  # deletes an existing attachment with params, corresponds to controller#destroy
  ########################################################################################
  def destroy_attachment(id, params={})
    destroy_object(:attachment, id, params)
  end #def
  
  end #module
end #module
