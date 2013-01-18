#coding: utf-8
module ChatsHelper
  require 'date'

  def html_maker(data)
    html = ''
    data.each do |m|
      case m.message_type
        when DATE, INVITATION, LEAVE
          html << info_maker(m)
        when MESSAGE
          html << "<div class = 'messageContainer'>"
          html << radio_maker(m)
          if m.isMine
            html << "<div class = 'messageDiv isMine'>"
            html << message_maker(m) << "<div class = 'time'>#{m.message_time}</div>"
          else
            html << "<div class = 'messageDiv isNotMine'>"
            html << "<div class = 'profilePicContainer'><div class = 'profilePic'></div></div>"
            html << "<div class = 'rightPart'> <div class = 'name'> #{m.name} </div>"
            html << message_maker(m) << "<div class = 'time'> #{m.message_time} </div></div>"
          end
          html << "</div></div>"
      end
    end
    html
  end

  def radio_maker(m)
    "<div class='radioDiv'><input type='radio' name='start' value='#{m.id}' /><input type='radio' name='end' value='#{m.id}'/></div>"
  end

  def message_maker(m)
    if m.content == TEXT
      "<div class = 'message textMessage'> #{m.message} </div>"
    elsif m.content == IMAGE
      "<div class = 'message imageMessage'> 
        <a class = 'messageImage' href='#{m.chat.get_file(m.message)}' target='_blank'> 
          <img src='/assets/uploaded/#{m.chat.get_file(m.message)}' /> 
        </a> 
      </div>"
    elsif m.content == AUDIO
      "<div class = 'message audioMessage'><a href = '#{m.message}'><img src = '/assets/voiceplay.png'></a></div>"
    elsif m.content == VIDEO
      "<div class = 'message videoMessage'><a href = '#{m.message}'><img src = '/assets/video.png'></a></div>"
    else
      "<div class = 'message unknownMessage'> #{m.message} </div>"
    end
  end

  def info_maker(m)
    "
      <div class = 'infoContainer'>
      #{radio_maker(m)}
        <div class = 'infoInnerContainer'>
          <div class = 'infoLeftContainer'>
            <div class = 'infoLeftCol'></div>
            <div class = 'info'> #{m.message} </div>
          </div>
        </div>
        <div class = 'infoRightCol'></div>
      </div>
    "
  end


end
