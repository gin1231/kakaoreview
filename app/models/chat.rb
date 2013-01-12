#coding: utf-8
class Chat < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :chatfile

  has_attached_file :chatfile


  belongs_to :user, :inverse_of => :chats
  has_many :messages
  has_and_belongs_to_many :readers, :class_name => "User", :join_table => "users_readable_chats"

  def parse_android(f)
    res = []
    parsed_date = ""
    f.each do |l|
      if l == "\r\n"
        next
      end
      if l.index('년').nil?
        # 사용자가 여러줄의 메시지를 보냈을 때
        next
      end
      if l.index('년') && l.index('월') && l.index('일') && l.index(',').nil?
        # 날짜 시간 시스템 메시지 패스
        next
      end
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
      hash.merge!(:name => name, :position => position) unless name.nil?
      if changed
        hash.merge!(:date => parsed_date)
      end
      hash.merge!(:time => time) unless time.nil?

      res << hash
    end
    res
  end

  def parse_ios(f)
    res = []
    parsed_date = ""
    f.each do |l|
      if l == "\r\n"
        next
      end

      if l.match(/\d{4}년 \d{1,2}월 \d{1,2}일 .요일/)
        # 날짜 시간 시스템 메시지 패스
        next
      end

      # set message type
      if l.match(/\d{4}\. \d{1,2}\. \d{1,2}\. 오(후|전) \d{1,2}:\d{1,2}:/) && l.match(/초대/)
        # 초대 system message
        type = INVITATION
      elsif l.match(/\d{4}\. \d{1,2}\. \d{1,2}\. 오(후|전) \d{1,2}:\d{1,2}:/) && l.match(/퇴장/)
        # 퇴장 system message
        type = LEAVE
      elsif l.match(/\d{4}\. \d{1,2}\. \d{1,2}\. 오(후|전) \d{1,2}:\d{1,2},/)
        # 사용자가 메시지를 보냈을 때
        type = MESSAGE
      elsif !l.match(/\d{4}\. \d{1,2}\. \d{1,2}\. 오(후|전) \d{1,2}:\d{1,2}/)
        # 사용자가 여러줄의 메시지를 보냈을 때
        type = MULTILINEMESSAGE
      else
        type = UNKNOWN
      end

      #parse date and set changed
      changed = false
      cond = (type == UNKNOWN or type == MULTILINEMESSAGE)
      unless cond
        date, time = parse_date_ios(l)
        unless parsed_date == date
          parsed_date = date
          changed = true
        end
      end

      info = l.sub(/\d{4}\. \d{1,2}\. \d{1,2}\. 오(후|전) \d{1,2}:\d{1,2}(,|:) /,'')
      if cond
        message = info[0..-3]
      else
        s = info.index(':')
        if s.nil?
          message = info[0..-3]
        else
          name = info[0..s-2]
          message = info[s+2..-3]
        end
      end
      position = LEFT

      hash = Hash.new
      hash.merge!(:type => type)
      hash.merge!(:message => parse_emoticons(message))
      hash.merge!(:name => name, :position => position) unless name.nil?
      if changed
        hash.merge!(:date => parsed_date)
      end
      hash.merge!(:time => time) unless time.nil?
      res << hash
    end
    res
  end

  def parse_date_ios(l)
    [l.match(/\d{4}\. \d{1,2}\. \d{1,2}\./).to_s, l.match(/오(후|전) \d{1,2}:\d{1,2}/).to_s]
  end

  def parse_file
    f = File.open(self.chatfile.path)
    f = f.drop(5)
    type = ANDROID
    if f.first.match(',')
      type = ANDROID
    else
      type = IOS
    end

    if type == ANDROID
      res = parse_android(f)
    else
      res = parse_ios(f)
    end
    res
  end

  def parse_emoticons(message)
    dict = Hash[ "(미소)" => 1, "(윙크)" => 2, "(방긋)" => 3, "(반함)" => 4, "(눈물)" => 5, "(절규)" => 6, "(크크)" => 7, "(메롱)" => 8, "(잘자)" => 9, "(잘난척)" => 10, "(헤롱)" => 11, "(놀람)" => 12, "(아픔)" => 13, "(당황)" => 14, "(풍선껌)" => 15, "(버럭)" => 16, "(부끄)" => 17, "(궁금)" => 18, "(흡족)" => 19, "(깜찍)" => 20, "(으으)" => 21, "(민망)" => 22, "(곤란)" => 23, "(잠)" => 24, "(행복)" => 25, "(안도)" => 26, "(우웩)" => 27, "(외계인)" => 28, "(외계인녀)" => 72, "(공포)" => 29, "(근심)" => 30, "(악마)" => 31, "(썩소)" => 32, "(쳇)" => 33, "(야호)" => 69, "(좌절)" => 70, "(삐짐)" => 71, "(하트)" => 34, "(실연)" => 74, "(별)" => 75, "(브이)" => 73, "(오케이)" => 35, "(최고)" => 36, "(최악)" => 37, "(그만)" => 38, "(땀)" => 39, "(알약)" => 40, "(밥)" => 41, "(커피)" => 42, "(맥주)" => 43, "(소주)" => 44, "(와인)" => 79, "(치킨)" => 78, "(축하)" => 45, "(음표)" => 46, "(선물)" => 47, "(케익)" => 48, "(촛불)" => 49, "(컵케익a)" => 50, "(컵케익b)" => 51, "(해)" => 52, "(구름)" => 53, "(비)" => 54, "(눈)" => 55, "(똥)" => 56, "(근조)" => 57, "(딸기)" => 58, "(호박)" => 59, "(입술)" => 60, "(야옹)" => 61, "(돈)" => 62, "(담배)" => 63, "(축구)" => 64, "(야구)" => 65, "(농구)" => 66, "(당구)" => 67, "(골프)" => 76, "(카톡)" => 68, "(꽃)" => 81, "(총)" => 82, "(크리스마스)" => 80, "(콜)" => 77 ] 
  
    dict.each do |k, v|
      message.gsub!(k, "<span class = 'emoticon'><img src = '/assets/emoticons/emo#{'%02d' % v}.png'></span>")
      #message.gsub!(k, "<span class = 'emoticon emoticon-#{v}'></span>")
    end

    message
  
  end

end
