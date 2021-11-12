# encoding: utf-8
#
# Ruby Gem to create a self populating Open Document Format (.odf) text file.
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

module ODFWriter

  ########################################################################################
  #
  # Style: add styles to styles.xml
  #
  ########################################################################################
  class Style
  
    ######################################################################################
    #
    # constants
    #
    ######################################################################################
    DOC_STYLES  = [:h1, :h2, :h3, :h4, :h5, :h6,                   # header        style
                   :paragraph, :subparagraph, :redmine             # paragraph     style
                   ]
                   
    AUT_STYLES  = [:bold, :underline, :italic, :strikethrough,     # character     style
                   :sub, :sup, :code, :a, :large, :medium, :small, # character     style
                                                                 
                   :center, :left, :right, :justify,               # paragraph     style
                   :p, :mono, :monoright, :monocenter, :cling,     # paragraph     style
                   :quote, :pre,                                   # paragraph     style
                    
                   :table, :thrifty, :tiny, :list, :listmedium,    # table         style
                   :invoice, :boxes, :caption,                     # table         style
                   
                   :tr, :td, :tdbott, :tdbox, :tdhead, :tdfoot,    # table content style
                   :tc, :tcnarrow, :tcwide, :tcfixed, :tcauto      # table content style
                   ]
                   
    LIST_STYLES = [:ul, :ol]
    
    ######################################################################################
    #
    # initialize
    #
    ######################################################################################
    def initialize( *styles )
      @styles = *styles
      @font  = {}
    end #def
    
    
    ######################################################################################
    #
    # add_style
    #
    ######################################################################################
    def add_automatic_style( doc )
      ns                                   = doc.collect_namespaces
      automatic_styles                     = doc.at("//office:automatic-styles", ns)
      font_declarations                    = doc.at("//office:font-face-decls", ns)
      
      @styles.each do |style|
        
        @font = nil # will be set in create_style
        automatic_styles                  << create_style( doc, style ) if automatic_styles.present?
        
        if @font.present?
          font_declarations               << create_font( doc, @font )  if font_declarations.present?
        end
      end
      
    end #def
    
    ######################################################################################
    #
    # add_style
    #
    ######################################################################################
    def add_document_style( doc )
      ns                                   = doc.collect_namespaces
      automatic_styles                     = doc.at("//office:document-styles", ns)
      font_declarations                    = doc.at("//office:font-face-decls", ns)
      
      @styles.each do |style|
        
        @font = nil # will be set in create_style
        automatic_styles                  << create_style( doc, style ) if automatic_styles.present?
        
        if @font.present?
          font_declarations               << create_font( doc, @font )  if font_declarations.present?
        end
      end
      
    end #def
    
    
    ######################################################################################
    #
    # private
    #
    ######################################################################################
    private
    
    def create_font( doc, font )
      node                               = Nokogiri::XML::Node.new('style:font-face', doc)
      node["style:name"]                 = font[:font_name]
      node["svg:font-family"]            = font[:font_family]
      node["style:font-family-generic"]  = font[:font_family_generic]
      node["style:font-pitch"]           = font[:font_pitch]
      node
    end #def
    
    def create_style( doc, stylename )
        
      style            = Nokogiri::XML::Node.new('style:style', doc)
      
      #
      # common properties
      #
      case stylename
      
        when :bold, :underline, :italic, :strikethrough, :sub, :sup, :code, :a, :large, :medium, :small
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="text"
          
          text_properties = Nokogiri::XML::Node.new('style:text-properties', doc)
          style << text_properties
          
        when /h(\d)/i
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="paragraph"
          style["style:parent-style-name"]                     ="Standard"
          style["style:next-style-name"]                       ="paragraph"
          style["style:default-outline-level"]                 =$1 #matches number behind 'h'
          
          paragraph_properties = Nokogiri::XML::Node.new('style:paragraph-properties', doc)
          style << paragraph_properties
          
          text_properties = Nokogiri::XML::Node.new('style:text-properties', doc)
          style << text_properties
          
        when :p, :mono, :monoright, :monocenter, :cling
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="paragraph"
          style["style:parent-style-name"]                     ="Standard"
          style["style:next-style-name"]                       ="paragraph"
          
          paragraph_properties = Nokogiri::XML::Node.new('style:paragraph-properties', doc)
          style << paragraph_properties
          
          text_properties = Nokogiri::XML::Node.new('style:text-properties', doc)
          style << text_properties
          
        when :subparagraph
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="paragraph"
          style["style:parent-style-name"]                     ="paragraph"
          style["style:next-style-name"]                       ="paragraph"
          
          paragraph_properties = Nokogiri::XML::Node.new('style:paragraph-properties', doc)
          style << paragraph_properties
          
          text_properties = Nokogiri::XML::Node.new('style:text-properties', doc)
          style << text_properties
          
        when :center, :left, :right, :justify
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="paragraph"
          style["style:parent-style-name"]                     ="paragraph"
          
          paragraph_properties = Nokogiri::XML::Node.new('style:paragraph-properties', doc)
          style << paragraph_properties
          
        when :quote, :pre
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="paragraph"
          style["style:parent-style-name"]                     ="Standard"
          
          paragraph_properties = Nokogiri::XML::Node.new('style:paragraph-properties', doc)
          style << paragraph_properties
          
          text_properties = Nokogiri::XML::Node.new('style:text-properties', doc)
          style << text_properties
          
        when :table, :list, :listmedium, :invoice, :boxes, :caption, :thrifty, :tiny
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="table"
          
          table_properties = Nokogiri::XML::Node.new('style:table-properties', doc)
          style << table_properties
          
        when :tr
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="table-row"
          
          table_row_properties = Nokogiri::XML::Node.new('style:table-row-properties', doc)
          style << table_row_properties
          
        when :tc, :tcnarrow, :tcwide, :tcfixed, :tcauto
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="table-column"
          
          table_column_properties = Nokogiri::XML::Node.new('style:table-column-properties', doc)
          style << table_column_properties
          
        when :td, :tdbott, :tdhead, :tdfoot, :tdbox
          style["style:name"]                                  =stylename.to_s
          style["style:family"]                                ="table-cell"
          
          table_cell_properties = Nokogiri::XML::Node.new('style:table-cell-properties', doc)
          style << table_cell_properties
          
      end
      
      #
      # individual properties
      #
      case stylename
      
        when :bold
          text_properties["fo:font-weight"]                           ="bold"
          text_properties["fo:font-weight-asian"]                     ="bold"
                    
        when :underline
          text_properties["style:text-underline-type"]                ="single"
          text_properties["style:text-underline-style"]               ="solid"
          text_properties["style:text-underline-width"]               ="auto" 
          text_properties["style:text-underline-mode"]                ="continuous" 
                    
        when :italic
          text_properties["fo:font-style"]                            ="italic"
          text_properties["fo:font-style-asian"]                      ="italic"
          
        when :strikethrough
          text_properties["style:text-line-through-style"]            ="solid"
          text_properties["style:text-line-through-type"]             ="single"
          
        when /h(\d)/i
          paragraph_properties["fo:text-align"]                       ="left"
          paragraph_properties["fo:line-height"]                      ="100%"
          paragraph_properties["fo:margin-left"]                      ="0cm"
          paragraph_properties["fo:margin-right"]                     ="0cm"
          paragraph_properties["fo:keep-with-next"]                   ="always"
          paragraph_properties["fo:margin-top"]                       ="1.25cm"
          paragraph_properties["fo:margin-right"]                     ="0cm"
          paragraph_properties["fo:margin-bottom"]                    ="0.5cm"
          paragraph_properties["fo:margin-left"]                      ="1.25cm"
          paragraph_properties["fo:text-indent"]                      ="-1.25cm"
          paragraph_properties["style:auto-text-indent"]              ="false"
          
          text_properties["fo:font-weight"]                           ="bold"
          text_properties["fo:font-weight-asian"]                     ="bold"
          text_properties["fo:hyphenate"]                             ="true"
          
        when :center, :left, :right, :justify
          paragraph_properties["fo:text-align"]                       =stylename.to_s
          
        when :quote
          paragraph_properties["fo:text-align"]                       ="justify"
          paragraph_properties["fo:line-height"]                      ="150%"
          paragraph_properties["fo:margin-top"]                       ="0.5cm"
          paragraph_properties["fo:margin-right"]                     ="1cm"
          paragraph_properties["fo:margin-bottom"]                    ="0.5cm"
          paragraph_properties["fo:margin-left"]                      ="1cm"
          
          text_properties["fo:hyphenate"]                             ="true"
          text_properties["fo:font-style"]                            ="italic"
          text_properties["fo:font-style-asian"]                      ="italic"
          
        when :mono
          paragraph_properties["fo:text-align"]                       ="left"
          paragraph_properties["fo:line-height"]                      ="100%"
          paragraph_properties["fo:margin-top"]                       ="0cm"
          paragraph_properties["fo:margin-right"]                     ="0.5cm"
          paragraph_properties["fo:margin-bottom"]                    ="0cm"
          paragraph_properties["fo:margin-left"]                      ="0cm"
          
          text_properties["fo:hyphenate"]                             ="false"
          text_properties["fo:font-weight"]                           ="bold"
          text_properties["fo:font-weight-asian"]                     ="bold"
        
        when :monoright
          paragraph_properties["fo:text-align"]                       ="right"
          paragraph_properties["fo:line-height"]                      ="100%"
          paragraph_properties["fo:margin-top"]                       ="0cm"
          paragraph_properties["fo:margin-right"]                     ="0cm"
          paragraph_properties["fo:margin-bottom"]                    ="0cm"
          paragraph_properties["fo:margin-left"]                      ="0cm"
          
          text_properties["fo:hyphenate"]                             ="false"
          text_properties["fo:font-weight"]                           ="bold"
          text_properties["fo:font-weight-asian"]                     ="bold"
          
        when :monocenter
          paragraph_properties["fo:text-align"]                       ="center"
          paragraph_properties["fo:line-height"]                      ="100%"
          paragraph_properties["fo:margin-top"]                       ="0cm"
          paragraph_properties["fo:margin-right"]                     ="0cm"
          paragraph_properties["fo:margin-bottom"]                    ="0cm"
          paragraph_properties["fo:margin-left"]                      ="0cm"
          
          text_properties["fo:hyphenate"]                             ="false"
          text_properties["fo:font-weight"]                           ="bold"
          text_properties["fo:font-weight-asian"]                     ="bold"
        
        when :pre
          paragraph_properties["fo:text-align"]                       ="left"
          paragraph_properties["fo:line-height"]                      ="100%"
          paragraph_properties["fo:margin-top"]                       ="0.5cm"
          paragraph_properties["fo:margin-right"]                     ="1cm"
          paragraph_properties["fo:margin-bottom"]                    ="0.5cm"
          paragraph_properties["fo:margin-left"]                      ="1cm"
          paragraph_properties["fo:background-color"]                 ="transparent"
          paragraph_properties["fo:padding"]                          ="0.05cm"
          paragraph_properties["fo:border"]                           ="0.06pt solid #000000"
          
          text_properties["fo:hyphenate"]                             ="true"
          text_properties["fo:font-style"]                            ="normal"
          text_properties["fo:font-style-asian"]                      ="normal"
          text_properties["style:font-name"]                          ="'Courier New'"
          @font = {
            :font_name            => "'Courier New'", 
            :font_family          => "'Courier New'", 
            :font_family_generic  => "system",
            :font_pitch           => "fixed"
          }

        when :code
          text_properties["style:font-name"]                          ="'Courier New'"
          @font = {
            :font_name            => "'Courier New'", 
            :font_family          => "'Courier New'", 
            :font_family_generic  => "system",
            :font_pitch           => "fixed"
          }
          
        when :cling
          paragraph_properties["fo:keep-together"]                    ="always"
          paragraph_properties["fo:keep-with-next"]                   ="always"
          
        when :sup
          text_properties["style:text-position"]                      ="super 58%"
          
        when :sub
          text_properties["style:text-position"]                      ="sub 58%"
          
        when :a
          text_properties["fo:color"]                                 ="#0000ff"
          text_properties["style:text-underline-type"]                ="single"
          text_properties["style:text-underline-style"]               ="solid"
          text_properties["style:text-underline-width"]               ="auto" 
          text_properties["style:text-underline-mode"]                ="continuous" 
        
        when :large
          text_properties["fo:font-size"]                             ="18pt"
          text_properties["style:font-size-asian"]                    ="18pt"
          text_properties["style:font-size-complex"]                  ="18pt"
          
        when :medium
          text_properties["fo:font-size"]                             ="9pt"
          text_properties["style:font-size-asian"]                    ="9pt"
          text_properties["style:font-size-complex"]                  ="9pt"
          
        when :small
          text_properties["fo:font-size"]                             ="8pt"
          text_properties["style:font-size-asian"]                    ="8pt"
          text_properties["style:font-size-complex"]                  ="8pt"
          
        when :table, :list, :invoice, :boxes
          table_properties["style:rel-width"]                         ="100%"
          table_properties["fo:margin-top"]                           ="0cm"
          table_properties["fo:margin-right"]                         ="0cm"
          table_properties["fo:margin-bottom"]                        ="0cm"
          table_properties["fo:margin-left"]                          ="0cm"
          table_properties["fo:text-align"]                           ="left"
        
        when :caption
          table_properties["style:rel-width"]                         ="100%"
          table_properties["fo:margin-top"]                           ="0cm"
          table_properties["fo:margin-right"]                         ="0cm"
          table_properties["fo:margin-bottom"]                        ="0cm"
          table_properties["fo:margin-left"]                          ="0cm"
          table_properties["fo:text-align"]                           ="left"
          
        when :thrifty, :tiny, :listmedium
          table_properties["style:rel-width"]                         ="50%"
          table_properties["table:align"]                             ="left"
          table_properties["fo:margin-top"]                           ="0cm"
          table_properties["fo:margin-right"]                         ="0cm"
          table_properties["fo:margin-bottom"]                        ="0cm"
          table_properties["fo:margin-left"]                          ="0cm"
          table_properties["fo:text-align"]                           ="left"
          
        when :tr
          # currently, nothing
        
        when :tc
          table_column_properties["style:column-width"]               ="5cm"
          table_column_properties["style:rel-column-width"]           ="100*"
          # MS Word errors, if this parameter is set
         #table_column_properties["style:use-optimal-column-width "]  ="true"
          
        when :tcfixed
          table_column_properties["style:column-width"]               ="5cm"
          table_column_properties["style:rel-column-width"]           ="100*"
         #table_column_properties["style:use-optimal-column-width "]  ="false"
          # for use with tcnarrow and tcwide
          
        when :tcnarrow
          table_column_properties["style:column-width"]               ="2.5cm"
          table_column_properties["style:rel-column-width"]           ="50*"
         #table_column_properties["style:use-optimal-column-width "]  ="false"
          
        when :tcwide
          table_column_properties["style:column-width"]               ="10.0cm"
          table_column_properties["style:rel-column-width"]           ="200*"
         #table_column_properties["style:use-optimal-column-width "]  ="false"
          
        when :tcauto
          table_column_properties["style:column-width"]               ="5cm"
          table_column_properties["style:rel-column-width"]           ="100*"
         #table_column_properties["style:use-optimal-column-width "]  ="true"
          
        when :td
          table_cell_properties["style:writing-mode"]                 ="lr-tb"
          table_cell_properties["fo:padding-top"]                     ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:padding-bottom"]                  ="0.2cm"
          table_cell_properties["fo:padding-left"]                    ="0cm"
          
        when :tdbott
          table_cell_properties["style:writing-mode"]                 ="lr-tb"
          table_cell_properties["style:vertical-align"]               ="bottom"
          table_cell_properties["fo:padding-top"]                     ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:padding-bottom"]                  ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          
        when :tdhead
          table_cell_properties["style:writing-mode"]                 ="lr-tb"
          table_cell_properties["fo:padding-top"]                     ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:padding-bottom"]                  ="0.2cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:border-bottom"]                   ="0.5pt solid #000000"
          
        when :tdfoot
          table_cell_properties["style:writing-mode"]                 ="lr-tb"
          table_cell_properties["fo:padding-top"]                     ="0.2cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:padding-bottom"]                  ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:border-top"]                      ="0.5pt solid #000000"
          
        when :tdbox
          table_cell_properties["style:writing-mode"]                 ="lr-tb"
          table_cell_properties["fo:padding-top"]                     ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:padding-bottom"]                  ="0cm"
          table_cell_properties["fo:padding-right"]                   ="0.2cm"
          table_cell_properties["fo:border"]                          ="0.5pt solid #000000"
      end
      
      style
    end #def
    
  end #class
end #module