function setFPS(f)
  local script = [[
    define(address,"libcocos2d.cocos2d::CCApplication::setAnimationInterval")
    alloc(newmem,$1000)
    label(code,return,fps_control_value)
    registersymbol(fps_control_value)
    newmem:
    code:
      divsd xmm0,xmm0
      divsd xmm0,[fps_control_value]
      movsd [ebp+08],xmm0
      jmp return
    fps_control_value:
      dq (double)60
    address:
      jmp newmem
    return:
  ]]
  if f==0 then return false end
  local function w(t,a,v)return({writeDouble})[t](getAddress(a),v)end
  local function r(t,a)return({readDouble})[t](getAddress(a))end
  if not autoAssemble(script) then return false end
  w(1,"fps_control_value",f)
  return r(1,"fps_control_value")==f
end


function showMessageBox(message,title,size,delay)
  delay = delay or 100
  size = size or 300
  local script = [[
    define(address,"libcocos2d.cocos2d::CCApplication::run"+A3)
    alloc(newmem,$1000)
    label(code)
    label(return)
    label(MSGBOX_toggle,MSGBOX_message,MSGBOX_title,MSGBOX_size,MSGBOX_message_length)
    alloc(MSGBOX_message_field,256)
    alloc(MSGBOX_title_field,256)
    registersymbol(MSGBOX_toggle,MSGBOX_message,MSGBOX_title,MSGBOX_size,MSGBOX_message_field,MSGBOX_title_field,MSGBOX_message_length)
    newmem:
    code:
      cmp [MSGBOX_toggle],0
      je endsc
      pushad
      call showMSGBOX
      popad
      mov [MSGBOX_toggle],0
      endsc:
      cmp [esi+00000095],al
      jmp return
    MSGBOX_toggle:
      dd 0
    MSGBOX_message:
      dd MSGBOX_message_field
    MSGBOX_title:
      dd MSGBOX_title_field
    MSGBOX_size:
      dd (float)600
    MSGBOX_message_length:
      dd 0
    showMSGBOX:
      push ebp
      mov ebp,esp
      and esp,-08
      sub esp,08
      mov eax,[GeometryDash.exe+31E000]
      xor eax,esp
      mov [esp+04],eax
      sub esp,18
      mov ecx,esp
      push [MSGBOX_message_length]
      mov [ecx+14],0000000F
      mov [ecx+10],00000000
      push [MSGBOX_message]
      mov byte ptr [ecx],00
      call GeometryDash.exe+F840
      push ecx
      mov edx,[MSGBOX_size]
      mov [esp],edx
      mov edx,[MSGBOX_title]
      push 00
      push GeometryDash.exe+28A9F4
      xor ecx,ecx
      call GeometryDash.exe+22730
      mov ecx,eax
      add esp,24
      mov eax,[ecx]
      call dword ptr [eax+000001FC]
      mov ecx,[esp+04]
      xor ecx,esp
      call GeometryDash.exe+261E27
      mov esp,ebp
      pop ebp
      ret
    address:
      jmp newmem
      nop
    return:
  ]]
  local function w(t,a,v)return({writeString,writeFloat,writeBytes,writeInteger})[t](getAddress(a),v)end
  local function r(t,a)return({readInteger})[t](getAddress(a))end
  if not autoAssemble(script) then return false end
  w(1,"MSGBOX_message_field",message)
  w(3,"MSGBOX_message_field+"..("%x"):format(#message),0)
  w(1,"MSGBOX_title_field",title)
  w(3,"MSGBOX_title_field+"..("%x"):format(#title),0)
  w(2,"MSGBOX_size",size)
  w(4,"MSGBOX_message_length",#message)
  sleep(delay)
  w(3,"MSGBOX_toggle",1)
  while r(1,"MSGBOX_toggle")==1 do end
  return r(1,"MSGBOX_toggle")==0
end
