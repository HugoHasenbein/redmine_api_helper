##
# aids creating fiddles for redmine_scripting_engine
#
# Copyright x 2021 Stephan Wenzel <stephan.wenzel@drwpatent.de>
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
  module ArgsHelper
  
  ########################################################################################
  # iterates over current object, set index for functions accessing current object
  ########################################################################################
  def iterate(&block)
    args.objects.map do |object|
      obj = yield object
      @index += 1 unless @index + 1 >= args.objects.length
      obj
    end
  end #def
  
  ########################################################################################
  # gets value of field in current object
  ########################################################################################
  def value( *fields )
    args.objects[index].deep_try(*fields)
  end #def
  
  ########################################################################################
  # serializes object to OpenStruct
  ########################################################################################
  def serialize(object, **options)
    if object.is_a?(Hash)
       OpenStruct.new(object.map{ |key, val| [ key, serialize(val, options) ] }.to_h)
    elsif object.is_a?(Array)
       object.map{ |obj| serialize(obj, options) }
    else # assumed to be a primitive value
      if options[:parse]
        JSON.parse(object, object_class:OpenStruct) rescue object 
      else
        object
      end
    end
  end #def
  
  ########################################################################################
  # serializes JSON string to OpenStruct
  ########################################################################################
  def jparse(object)
    serialize(object, :parse => true)
  end #def
  
  ########################################################################################
  # deserializes object from OpenStruct
  ########################################################################################
  def deserialize(object)
    if object.is_a?(OpenStruct)
      return deserialize( object.to_h )
    elsif object.is_a?(Hash)
      return object.map{|key, obj| [key, deserialize(obj)]}.to_h
    elsif object.is_a?(Array)
      return object.map{|obj| deserialize(obj)}
    else # assumed to be a primitive value
      return object
    end
  end #def
    
  ########################################################################################
  # print pretty arguments passed to ruby script by plugin
  ########################################################################################
  def pretty(a=args)
    JSON.pretty_generate(deserialize(a))
  end #def
  
  ########################################################################################
  # print pretty response returned from http request
  ########################################################################################
  def pretty_response(hr=@http_response)
    JSON.pretty_generate({
      :code => hr.try(:code),
      :body => JSON.parse(hr.try(:body).to_s)
    })
  end #def
  
  ########################################################################################
  # create html link
  ########################################################################################
  def link_to(body, url)
    "<a href='#{url}'>#{body}</a>"
  end #def
  
  end #module
end #module