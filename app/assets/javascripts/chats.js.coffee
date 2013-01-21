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
window.toggleRadio = () ->
  $(".radioDiv").toggle()

window.newPart = (new_path) ->
  start_div = $('input[name=start]:checked')
  end_div = $('input[name=end]:checked')

  if (start_div.length == 0) or (end_div.length == 0)
    alert('시작지점과 끝지점을 선택해주세요')
  else
    start = start_div.val()
    end = end_div.val()

    if start > end
      alert('시작지점이 더 앞이어야 합니다')
    else
      window.location = new_path + "?start=" + start + "&end=" + end
