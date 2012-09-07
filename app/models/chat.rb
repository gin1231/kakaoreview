#coding: utf-8
class Chat < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :chatfile

  has_attached_file :chatfile

  MESSAGE = 0
  INVITATION = 1
  LEAVE = 2
  UNKNOWN = 3

  LEFT = 0
  RIGHT = 1
  def parse_file
    res = []
    f = File.open(self.chatfile.path)
    parsed_date = ""
    f.drop(5).each do |l|
      # split datetime and others
      s = l.index(',')
      datetime = l[0..s-1]
      info = l[s+2..-1]

      # parse datetime

      s = datetime.index('일')
      date = datetime[0..s]
      time = datetime[s+2..-1]

      changed = false
      unless parsed_date == date
        parsed_date = date
        changed = true
      end


      # split name and message
      
      s = info.index(':')
      # 메시지가 아닌 system message
      if s.nil?
        name = nil
        unless info.index("초대").nil?
          type = INVITATION
          message = info[0..-3]
        else
          type = LEAVE
          message = info[0..-3]
        end
      # 사용자가 보낸 메시지
      else
        type = MESSAGE
        name = info[0..s-2]
        message = info[s+2..-3]
        position = LEFT
      end
      #
      # merge infos
      hash = Hash.new
      hash.merge!(:type => type)
      hash.merge!(:message => message)
      unless name.nil?
        hash.merge!(:name => name, :position => position)
      end
      if changed
        hash.merge!(:date => parsed_date)
      end
      hash.merge!(:time => time)

      res << hash
    end
    res
  end
end
