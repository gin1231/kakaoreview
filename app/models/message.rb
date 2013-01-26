#encoding: utf-8
class Message
  include Mongoid::Document

  #=== Constants
  MINE = {:id => true, :name => '나'}
  NOTMINE = {:id => false, :name => '상대방'}
  TYPE_ISMINE = [MINE, NOTMINE]

  H_TEXT = {:id => TEXT, :name => '텍스트'}
  H_IMAGE = {:id => IMAGE, :name => '이미지'}
  H_AUDIO = {:id => AUDIO, :name => '오디오'}
  H_VIDEO = {:id => VIDEO, :name => '비디오'}
  TYPE_CONTENT = [H_TEXT, H_IMAGE, H_VIDEO, H_AUDIO]

  H_MESSAGE = {:id => MESSAGE, :name => '메시지'}
  H_DATE = {:id => DATE, :name => '날짜'}
  H_INVITATION = {:id => INVITATION, :name => '초대메시지'}
  H_LEAVE = {:id => LEAVE, :name => '퇴장메시지'}
  H_UNKNOWN = {:id => UNKNOWN, :name => 'UNKNOWN'}
  H_FREE = {:id => FREE, :name => '자유메시지' }

  TYPE_MESSAGE = [H_MESSAGE, H_DATE, H_INVITATION, H_LEAVE, H_FREE]

  WEEKDAYS = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"] 

  #=== Fields
  field :message_type, type: Integer
  field :message, type: String
  field :content, type: Integer
  field :name, type: String
  field :isMine, type: Boolean
  field :message_date, type: String
  field :message_time, type: String



  attr_accessible :message_type, :content, :message, :name, :isMine, :message_date, :message_time

  embedded_in :chat

  # Message Type Defined in config/initializers/chat_type.rb
  

  #=== Methods
  def self.current_date
    cur_time = Time.now
    day_of_week = cur_time.strftime("%w").to_i

    date = cur_time.strftime("%Y년 %m월 %-d일 ") + WEEKDAYS[day_of_week]
    date
  end

  def self.option_for_ismine
    v = []
    TYPE_ISMINE.each do |e|
      v << [e[:name], e[:id]]
    end
    v
  end

  def self.option_for_content
    v = []
    TYPE_CONTENT.each do |e|
      v << [e[:name], e[:id]]
    end
    v
  end

  def self.option_for_messagetype
    v = []
    TYPE_MESSAGE.each do |e|
      v << [e[:name], e[:id]]
    end
    v
  end

end
