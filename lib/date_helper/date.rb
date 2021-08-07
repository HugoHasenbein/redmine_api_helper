##
# encoding: utf-8
#
# Extension for Date to calculate a forward date with compressed syntax
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

class Date

  ####################################################################################
  #
  # Date.today.calc(<rule>) -> [<new_date>, <new_rule>]
  # Date.today.forward(<rule)  ->  <new_date>
  # 
  # <rule>: [DWmMqy][n][FMLWX][-!*]
  #
  # 1. parameter: epoch-identifier (necessary)
  # 
  #  D - stands for _D_ays
  #  W - stands for _W_eeks
  #  m - stands for _m_ondays
  #  M - stands for _M_onths
  #  q - stands for _q_uarters
  #  Y - stands for _Y_ears
  # 
  # 2. parameter: integer (necessary)
  # 
  #  n - stands for the number of epochs
  #  
  # 3. position of day within epoch 
  # 
  #  F - stands for _F_irst day of epoch, like first day of month, monday, first day of 
  #      quarter, or January 1st
  #  M - stands for _M_id of epoch, like 15th day of month, wednesday, 15th of 
  #      mid-of-quarter or June 30th
  #  L - stands for _L_ast of epoch, like last day of month, friday (last working day),
  #      last day of quarter or December 31st
  #  W - stands for _W_eekday (Monday), if calculated day falls on a Saturday or Sunday
  #  X - stands for no correction
  # 
  # 3. control of date calculation
  # 
  #  - - the sign "-" is a killswitch. After one date calculation the resubmission rule is 
  #      deleted, so no further resubmissions happen
  #  ! - the sign "!" is a force sign to force date calculation even if a resubmission date
  #      present
  #  * - the sign "*" is a mock switch. The mock-switch is deleted from the resubmission-rule
  #      and no resubmission-date is calculated. Needed for Redmine Attribute-Quickie plugin
  #      
  # Example: W1F  - one week further, first day, so monday 
  # Example: M3M  - three months further from today, mid-term, so 15th of month
  # Example: q1-  - next quarter, first day of quarter, so 1st Jan., Apr., Jul. or Oct., after
  #                 one calculation further calculations are stopped, rule is deleted.
  # Example: D1-  - tomorrow, then delete rule 
  # Example: D1-! - tomorrow!, regardsless of date
  #                
  # Resubmission dates are always calculated for the future, never for the past. 
  # So W0F would calculate "next monday"", if calculated on a friday, though W0 stands for 
  # this week (W0 zero weeks further, first day, monday) and would calculate last monday. 
  # In this case, the calculated date is advanced monday further into the future.
  # So q0M would calculate "this quarter mid-term" if calculated near to lapse of current 
  # quarter. In this case the calculated date is advanced one quarter into the future.
  ####################################################################################
 
  ####################################################################################
  # calc
  ####################################################################################
  def calc( rule )
  
    new_date = nil
    new_rule = nil
    
    if rule.present?
    
      m = parse_rule( rule )
      
      if m['mockswitch'].present?
      
        # mockswitch does not calculate anything
        # mockswitch is removed from new_rule, however
        new_rule = unmock( rule, m )
        
      elsif self <= Date.today || m['force'].present?
      
        if( m['epoch'].present? && m['num'].present? )
        
          new_date = move(   m['epoch'], m['num'] )
          new_date = new_date.adjust( m['epoch'], m['pos'], self )
          
          if m['killswitch'].present?
            new_rule  = "" 
          else
            new_rule  = rule
          end
          
        end #if
      end #if
    end #if
    
    [new_date, new_rule]
    
  end #def
  
  ####################################################################################
  # forward
  ####################################################################################
  def forward( rule )
    calc( rule ).first
  end #def
  
  ####################################################################################
  # calculate num times advance of epoch
  # epoch: D - n days
  # epoch: W - n weeks
  # epoch: M - n months
  # epoch: Y - n years
  # 
  # epoch: C - n calendar weeks (absolute, within this year, not relative)
  # epoch: m - n mondays
  # epoch: q - q quarters
  ####################################################################################
  def move( epoch, num )
    case epoch  
    when "D"
        self + num.to_i
    when "W"
        self + num.to_i * 7
    when "M"
        self >> num.to_i
    when "Y"
        self >> num.to_i * 12
    when "m"
        (self + num.to_i * 7).monday 
    when "q"
        (self >> num.to_i * 3).beginning_of_quarter
    when "C"
        # calendar week 1 is the week containing Jan. 4th
        change(:month => 1, :day => 4).advance( :weeks => (num.to_i - 1))
    else
      self
    end #case
  end #def
  
  ####################################################################################
  # calculate time adjustmentfor pos in epoch (_F_irst, _M_id, _L_ast, _W_orking day)
  # epoch: D - day:                                          W - Monday
  # epoch: W - week:  F - Monday, M - Wednesday, L - Friday, W - Monday
  # epoch: M - month: F - 1st,    M - 15th,      L - last,   W - Monday
  # epoch: Y - year:  F - 01/01,  M - 06/30,     L - 12/31,  W - Monday
  # epoch: q - quarter:                                      W - Monday
  ####################################################################################
  def adjust( epoch, pos, ref=self )
  
    case epoch
    when "D"
      case pos
      when "W"
        # if saturday or sunday, fall back to last monday, then add one week for monday coming up
        (wday % 6) != 0 ? self : monday.advance(:days => 7)
      else
        self
      end #case
      
    when "W", "C"
      # week
      case pos
      when "F"
        # Monday
        monday < ref ? advance( :weeks => 1).monday : monday
        
      when "M"
        # Wednesday = Monday + 2 days
        monday.advance(:days => 2) < ref ? advance( :weeks => 1).monday.advance(:days => 2) : monday.advance(:days => 2)
        
      when "L"
        # Friday = Monday + 4 days
        monday.advance(:days => 4) < ref ? advance( :weeks => 1).monday.advance(:days => 4) : monday.advance(:days => 4)
        
      when "W"
      # if saturday or sunday, fall back to last monday, then add one week for monday coming up
        (wday % 6) != 0 ? self : monday.advance(:days => 7)
        
      else
        self
      end #case
      
    when "M"
      # month
      case pos
      when "F"
        # 1st
        change(:day => 1) < ref ? advance( :months => 1).beginning_of_month.change(:day => 1) : change(:day => 1)
        
      when "M"
        # 15th 
        change(:day => 15) < ref ? advance( :months => 1).beginning_of_month.change(:day => 15) : change(:day => 15)
        
      when "L"
        # last day
        end_of_month
        
      when "W"
      # if saturday or sunday, fall back to last monday, then add one week for monday coming up
        (wday % 6) != 0 ? self : monday.advance(:days => 7)
      else
        self
      end #case
      
    when "Y"
      # year
      case pos
      when "F"
        # Jan. 1st
        beginning_of_year < ref ? advanve(:years => 1).beginning_of_year : beginning_of_year
        
      when "M"
        # Jun. 30th
        change(:month => 5, :day => 30) < ref ? advance(:years => 1).change(:month => 5, :day => 30) : change(:month => 5, :day => 30)
        
      when "L"
        # Dec. 31st
        change(:month => 12, :day => 31)
        
      when "W"
      # if saturday or sunday, fall back to last monday, then add one week for monday coming up
        (wday % 6) != 0 ? self : monday.advance(:days => 7)
      else
        self
      end #case
      
    when "q"
      case pos
      when "F"
        # Jan. 1st
        beginning_of_quarter < ref ? advance( :months => 3).beginning_of_quarter : beginning_of_quarter
        
      when "M"
        # mid quarter
        beginning_of_quarter.advance(:months => 1).advance(:days => 14) < ref ? advance(:quarters => 1).beginning_of_quarter.advance(:months => 1).advance(:days => 14) : beginning_of_quarter.advance(:months => 1).advance(:days => 14)
        
      when "L"
        # end quarter
        end_of_quarter
        
      when "W"
      # if saturday or sunday, fall back to last monday, then add one week for monday coming up
        (wday % 6) != 0 ? self : monday.advance(:days => 7)
      else
        self
      end #case
      
    else
      self
    end #case epoch
  end #def
  
  
  ####################################################################################
  # private
  ####################################################################################
  private
  
  ####################################################################################
  # parse_rule
  ####################################################################################
  def parse_rule(rule)
  
    m = {}
    matches = /(?<epoch>[DWMYCmq])(?<num>[0-9]+)(?<pos>[XFMLW]?)(?<kfm>[-!\*]*)(?<trailing_rest>.*)/.match(rule)
    
    if matches.present?
      m.merge!(Hash[ matches.names.zip( matches.captures ) ])
      m.merge!('killswitch' => m['kfm'].match(/-/).to_s)
      m.merge!('force'      => m['kfm'].match(/!/).to_s)
      m.merge!('mockswitch' => m['kfm'].match(/\*/).to_s)
    end
    m
  end #def
  
  ####################################################################################
  # parse_rule
  ####################################################################################
  def unmock( rule, m=nil )
    m = parse_rule( rule ) unless m
    if m['mockswitch'].present?
      "#{m['epoch']}#{m['num']}#{m['pos']}#{m['killswitch']}#{m['force']}#{m['trailing_rest']}"
    else
      nil
    end
  end #def
  
end #class

