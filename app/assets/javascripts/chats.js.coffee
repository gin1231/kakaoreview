#edit
window.toggleTitle = () ->
  $(".chatTitle").toggle()

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
