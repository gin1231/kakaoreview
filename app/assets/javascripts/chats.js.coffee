#show
$(document).ready ->
  $("#message_message_type").change(() ->
    message_type = parseInt($("#message_message_type option:selected").val())

    if message_type == 0
      #DATE
      $("#message_message").val(getDateString(new Date))
    else if message_type == 3
      #INVITATION
      $("#message_message").val("님이 님을 초대했습니다.")
    else if message_type == 4
      #LEAVE
      $("#message_message").val("님이 퇴장했습니다.")
    else
      $("#message_message").val("")
  )

WEEKDAYS = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
getDateString = (date) ->
  str = date.getFullYear() + "년 "
  str = str + (date.getMonth()+1) + "월 "
  str = str + date.getDate() + "일 "
  str = str + WEEKDAYS[date.getDay()]
  return str


#edit
window.toggleTitle = () ->
  $(".chatTitle").toggle()

window.toggleEdit = () ->
  $(".editDiv").toggle()

#share
start_div = null
end_div = null

chat_id = null

window.toggleShare = (id) ->
  message_divs = $(".infoContainer, .messageContainer")
  if id
    chat_id = id
    toggleShareStart(id)
  else
    message_divs.off()
    message_divs.css('background-color', '')
    chat_id = null


toggleShareStart = () ->
  alert('시작지점을 선택해주세요')
  start_div = null
  end_div = null
  message_divs = $(".infoContainer, .messageContainer")
  message_divs.on("mouseenter", (event) ->
    $(this).css('background-color', '#ecc')
    $(this).click( () ->
      start_div = $(this)
      toggleShareEnd()
    )
  )
  message_divs.on("mouseleave", (event) ->
    $(this).css('background-color', '')
  )
  return

toggleShareEnd = () ->
  alert('끝지점을 선택해주세요')
  message_divs = $(".infoContainer, .messageContainer")
  message_divs.off()
  message_divs.on("mouseenter", (event) ->
    $(this).css('background-color', '#cec')
    $(this).click( () ->
      end_div = $(this)
      message_divs.css('background-color', '')
      newPart()
    )
  )
  message_divs.on("mouseleave", (event) ->
    $(this).css('background-color', '')
  )
  return

newPart = () ->
  message_divs = $(".infoContainer, .messageContainer")
  message_divs.off()
  if (start_div == null) or (end_div == null)
    alert('잘못된 접근입니다')
  else
    start = start_div.attr("id").split("_")[1]
    end = end_div.attr("id").split("_")[1]

    if start > end
      alert('시작지점이 더 앞이어야 합니다')
      toggleShareEnd()
    else
      $.colorbox({href: "/chats/" + chat_id + "/parts/new?start=" + start + "&end=" + end})
      toggleShare()
  return
